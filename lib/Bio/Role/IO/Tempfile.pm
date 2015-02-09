package Bio::Role::IO::Tempfile;

use Moose::Role;
use File::Temp;
use Method::Signatures;

#requires 'fh', 'file';

has 'save_tempfiles' => (
    isa         => 'Bool',
    is          => 'rw',
    default     => 0
);

has 'tempfiles'     => (
    isa         => 'ArrayRef[Str]',
    is          => 'ro',
    traits      => ['Array'],
    default     => sub {[]},
    handles     => {
        add_tempfile    => 'push'
        }
);

method tempfile(%args) {
    my ($tfh, $file);
    
    $args{'TMPDIR'} = 1 if(! exists($args{'DIR'}));
        
    if(exists($args{'TEMPLATE'})) {
        my $template = $args{'TEMPLATE'};
        delete $args{'TEMPLATE'};
        ($tfh, $file) = File::Temp::tempfile($template, %args);
    } else {
        ($tfh, $file) = File::Temp::tempfile(%args);
    }
    $self->_set_file($file);
    $self->_set_fh($tfh);
    if(  $args{'UNLINK'} ) {
        $self->add_tempfile($file);
    } 
    return wantarray ? ($tfh,$file) : $tfh;
}

method tempdir(@args) {
    return File::Temp::tempdir(@args);
}

# not sure we should do this in a role...
method cleanup() {
    if (!$self->save_tempfiles) {
        unlink(@{$self->tempfiles});
    }
}

no Moose::Role;

1;

__END__

