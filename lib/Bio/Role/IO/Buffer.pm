package Bio::Role::IO::Buffer;

use Moose::Role;
use Method::Signatures;

#requires 'fh';

has  buffer     => (
    isa     => 'ArrayRef[Str]',
    traits  => ['Array'],
    is      => 'ro',
    handles  => {
        '_push_buffer'  => 'push',
        '_shift_buffer' => 'shift',
        'has_buffer'    => 'count',
        'clear_buffer'  => 'clear'
        },
    default => sub {[]}
);

method readline() {
    my %param =@_;
    my $fh = $self->fh or return;
    my $line;
    # if the buffer been filled by pushback() then return the buffer
    # contents, rather than read from the filehandle
    if( $self->has_buffer ) {
        $line = $self->_shift_buffer;
    } else {
        $line = <$fh>;
    }
    
    if(
       #!$HAS_EOL &&
       !$param{-raw} && (defined $line) ) {
        $line =~ s/\015\012/\012/g; # Change all CR/LF pairs to LF
        $line =~ tr/\015/\n/;
    }
    return $line;
}

method pushback($value) {
    if (index($value, $/) >= 0 || eof($self->fh)) {
        $self->_push_buffer($value);
    } else {
        $self->throw("Pushing back data with modified line ending ".
                     "is not supported: $value");
    }
}

method print() {
    my $fh = $self->fh() || \*STDOUT;
    my $ret = print $fh @_;
    return $ret;
}

after 'close' => sub {
    my ($self) = @_;
    return if $self->no_close;
    $self->clear_buffer;
};

no Moose::Role;

1;

__END__
