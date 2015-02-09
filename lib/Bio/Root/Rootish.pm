package Bio::Root::Rootish;
our $VERSION = '0.001';

# ABSTRACT: Moose-based implementation of L<Bio::Root::RootI> methods, reimplemented via a role
# AUTHOR:   Chris Fields <cjfields at cpan dot org>
# OWNER:    Chris Fields
# LICENSE:  Perl_5

use Bio::Root::MOP;
use namespace::autoclean;
use MooseX::NonMoose;
use Bio::Root::RootI;
use Method::Signatures;

extends qw(Bio::Root::RootI);
with qw(Bio::Role::Root);

#sub new {
##    my ($class, %param) = @_;
#    my $class = shift;
#    my $self = {};
#    bless $self, ref($class) || $class;
#
#    if(@_ > 1) {
#        # if the number of arguments is odd but at least 3, we'll give
#        # it a try to find -verbose
#        shift if @_ % 2;
#        my %param = @_;
#        ## See "Comments" above regarding use of _rearrange().
#        #$self->verbose($param{'-VERBOSE'} || $param{'-verbose'});
#    }
#    return $self;
#}

method throw() {
    ...
}

method warn() {
    ...
}

method deprecated() {
    ...
}

method stack_trace_dump() {
    ...
}

method stack_trace() {
    ...
}

method throw_not_implemented() {
    ...
}

method warn_not_implemented() {
    ...
}

method _not_implemented_msg() {
    ...
}

method _rearrange() {
    ...
}

method _set_from_args() {
    ...
}

method _register_for_cleanup() {
    ...
}

method _unregister_for_cleanup() {
    ...
}

method _cleanup_methods() {
    ...
}

__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;

__END__

