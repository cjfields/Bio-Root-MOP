package Bio::Root::Rootish;
our $VERSION = '0.001';

# ABSTRACT: Moose-based implementation of L<Bio::Root::RootI> methods, reimplemented via a role
# AUTHOR:   Chris Fields <cjfields at cpan dot org>
# OWNER:    Chris Fields
# LICENSE:  Perl_5

use 5.016;
use Bio::Root::MOP;
use namespace::autoclean;
use MooseX::NonMoose;
use Method::Signatures;
use Data::Dumper;

extends qw(Bio::Root::Root);

# pull in role methods (these should supercede the above if pulled in after,
# let's test that)
with qw(Bio::Role::Root);

no Bio::Root::MOP;

__PACKAGE__->meta->make_immutable();

1;

__END__

