package Bio::Role::IO::Buffer_Unread;
use IO::Unread qw(unread);

use Moose::Role;

#requires 'fh';

sub readline {
    my $self = shift;
    my %param =@_;
    my $fh = $self->fh or return;
    my $line = <$fh>;
    return $line;
}

sub pushback {
    my ($self, $value) = @_;
    if (index($value, $/) >= 0 || eof($self->fh)) {
        unread $self->fh, $value;
    } else {
        $self->throw("Pushing back data with modified line ending ".
                     "is not supported: $value");
    }
}

sub print {
    my $self = shift;
    my $fh = $self->fh() || \*STDOUT;
    my $ret = print $fh @_;
    return $ret;
}

no Moose::Role;

1;

__END__

