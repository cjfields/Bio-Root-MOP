package Bio::Util;

use Moose::Util;
use strict;
use warnings;

use overload ();

my @exports = qw[
    throw_exception rearrange
];

Sub::Exporter::setup_exporter({
    exports => \@exports,
    groups  => { all => \@exports }
});

sub throw_exception {
    my ($class_name, @args_to_exception) = @_;
    my $class = $class_name ? "Bio::Exception::$class_name" : "Bio::Exception";
    Moose::Util::_load_user_class( $class );
    die $class->new( @args_to_exception );
}

# From Bio::GFF::Util::Rearrange from L. Stein

sub rearrange {
    my($order,@param) = @_;
    return unless @param;
    my %param;

    if (ref $param[0] eq 'HASH') {
      %param = %{$param[0]};
    } else {
      return @param unless (defined($param[0]) && substr($param[0],0,1) eq '-');

      my $i;
      for ($i=0;$i<@param;$i+=2) {
        $param[$i]=~s/^\-//;     # get rid of initial - if present
        $param[$i]=~tr/a-z/A-Z/; # parameters are upper case
      }

      %param = @param;                # convert into associative array
    }

    my(@return_array);

    local($^W) = 0;
    my($key)='';
    foreach $key (@$order) {
        my($value);
        if (ref($key) eq 'ARRAY') {
            foreach (@$key) {
                last if defined($value);
                $value = $param{$_};
                delete $param{$_};
            }
        } else {
            $value = $param{$key};
            delete $param{$key};
        }
        push(@return_array,$value);
    }
    push (@return_array,\%param) if %param;
    return @return_array;
}


1;

