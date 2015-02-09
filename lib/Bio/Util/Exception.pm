package Bio::Util::Exception;

use Moose::Util;
use strict;
use warnings;

use overload ();

my @exports = qw[
    throw_exception
];

Sub::Exporter::setup_exporter({
    exports => \@exports,
    groups  => { all => \@exports }
});

sub throw_exception {
    my ($class_name, @args_to_exception) = @_;
    my $class = $class_name ? "Biome::Exception::$class_name" : "Biome::Exception";
    Moose::Util::_load_user_class( $class );
    die $class->new( @args_to_exception );
}

1;
