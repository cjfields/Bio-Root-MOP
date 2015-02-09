package Bio::Root::MOP;
our $VERSION = '0.001';

# ABSTRACT: Moose-based implementation of L<Bio::Root::RootI> methods, reimplemented via a role
# AUTHOR:   Chris Fields <cjfields at cpan dot org>
# OWNER:    Chris Fields
# LICENSE:  Perl_5

use Moose::Exporter;
use Moose 2.1100;

Moose::Exporter->setup_import_methods(
    also    => 'Moose',
    base_class_roles => ['Bio::Role::Root']
);

1;

__END__

