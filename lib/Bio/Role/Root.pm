package Bio::Role::Root;

use 5.016;
use Moose::Role;
use Moose::Exception;
use Module::Runtime ();
use Bio::Util qw(throw_exception rearrange);
use Method::Signatures;

has 'verbose' => (
    is   => 'rw',
    isa  => 'Bool',
    default => $ENV{BIOPERL_DEBUG} || 0
    );

# strictness level; setting to True converts warnings to exceptions
has 'strict' => (
    is      => 'rw',
    isa     => 'Int',
    default => $ENV{BIOPERL_STRICT} || 0
    );

method warn ($string) {
    my $strict = $self->strict || $self->verbose;

    my $header = "\n--------------------- WARNING ---------------------\nMSG: ";
    my $footer =   "---------------------------------------------------\n";
    if ($strict >= 2) {
        $self->throw($string);
    }
    elsif ($strict <= -1) {
        return;
    }
    elsif ($strict == 1) {
        CORE::warn $header. $string. "\n". $self->meta->stack_trace_dump. $footer;
        return;
    }

    CORE::warn $header. $string. "\n". $footer;
}

method throw ($text, $class = '', $value?) {
    throw_exception($class, message =>  $text);
}

method deprecated () {
    my $prev = (caller(0))[3];
    my $msg = "Use of ".$prev."() is deprecated";
    # delegate to either warn or throw based on whether a version is given
    $self->warn($msg);
}

method throw_not_implemented {
    $self->throw(text => $self->_not_implemented_msg); 
}

method warn_not_implemented () {
    $self->warn( $self->_not_implemented_msg );
}

method _not_implemented_msg () {
    my $pkg = ref $self;
    my $meth = (caller(2))[3]; # may not work as intended here;
    my $msg =<<EOD_NOT_IMP;
Abstract method \"$meth\" is not implemented by package $pkg.
This is not your fault - author of $pkg should be blamed!
EOD_NOT_IMP
    return $msg;
}

method debug (@msgs) {
    if ($self->verbose) {
        CORE::warn @msgs;
    }
}

# TODO: may add some optional support class here
method clone (@p) {
    my $params = $self->BUILDARGS(@p);
    $self->meta->clone_object($self, %$params);
}

# cleanup methods needed?  These should probably go into the meta class

# Module::Load::Conditional caches already loaded modules
method load_modules (@mods) {
    Class::Load::load_class($_) for @mods;
}

method load_module ($mod) {
    Class::Load::load_class($mod);
}

# method call for _rearrange which now simply delegates to simple function call
# As might be expected, no longer recommended over the simple function call :)

method _rearrange() {
    rearrange(@_);
}

1;

__END__

