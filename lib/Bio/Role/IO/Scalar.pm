package Bio::Role::IO::Scalar;

use Moose::Role;

#requires 'fh';

my %VALID_MODES = (
    'r'         => '<',
    '<'         => '<',
    'w'         => '>',
    '>'         => '>',
    'rw'        => '+<',
    '+<'        => '+<',
    'append'    => '>>',
    '>>'        => '>>',
);

has scalar   => (
    is          => 'ro',
    isa         => 'ScalarRef[Any]',
    trigger     => sub {
        my ($self, $new) = @_;
        # do we want to allow writable strings?  How would we do that?
        open(my $fh, $self->scalar_mode, $new);
        $self->_set_fh($fh);
    }
);

has scalar_mode   => (
    is      => 'ro',
    isa     => 'Str',
    default => '<',
    trigger => sub {
        my ($self, $new) = @_;
        if (!$VALID_MODES{$new}) {
            $self->throw("Unknown mode: $new");
        }
    }
);

no Moose::Role;

1;

__END__

