package Bio::Root::IO::Base;

use Bio::Root::MOP;

#our $VERSION = '0.001';

# ABSTRACT: Moose-based implementation of L<Bio::Root::IO> file and file handle methods.
# AUTHOR:   Chris Fields <cjfields at cpan dot org>
# OWNER:    Chris Fields
# LICENSE:  Perl_5

# A simple wrapper around an IO::Handle instance
with 'Bio::Role::IO::Handle';

# here we simply need to set fh appropriately, or require mode
with 'Bio::Role::IO::File';

# this we may retain, maybe have it pull in this (possibly optional) XS module
# at BEGIN time if present; we have a pure perl fallback if needed
#
# For now we use pure perl version; could load in XS version if present

with 'Bio::Role::IO::Buffer';

no Bio::Root::MOP;

1;

__END__

