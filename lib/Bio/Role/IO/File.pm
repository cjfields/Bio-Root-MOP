package Bio::Role::IO::File;

use Moose::Role;

#requires 'fh';

my %VALID_MODES = map { $_ => 1} qw(> < >> +< +>);

has file   => (
    is      => 'ro',
    isa     => 'Str',
    writer  => '_set_file',
    trigger => sub {
        my ($self, $new) = @_;
        my $mode = '<'; # default is read
        if ($new =~ s/^\s*([\+\<\>]{1,2})\s*//) {
            $mode = $1;
            if (!exists $VALID_MODES{$mode}) {
                $self->throw("Unknown mode: $mode");
            }
        }
        open(my $new_fh, $mode, $new) or die "$!:$new";
        
        $self->_set_fh($new_fh);
    }
);

no Moose::Role;

1;

__END__
