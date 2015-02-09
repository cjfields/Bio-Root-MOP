package Bio::Role::IO::Handle;

use Moose::Role;
use Method::Signatures;
use IO::Handle;

# may need to make more portable
use Fcntl;

has 'fh'    => (
    isa     => 'FileHandle',
    writer  => '_set_fh',  # private
    is      => 'ro'
);

has 'no_close'  => (
    is      => 'rw',
    isa     => 'Bool'
);

has flush_on_write  => (
    is      => 'ro',
    isa     => 'Bool',
    default => 1
);

# TODO: portability?  May need various helpers based on OS (this is UNIX-y)...
method mode() {
    my $fh = $self->fh;
    if ($self->does('Bio::Role::IO::Scalar') and $self->scalar) {
        return 'r';
    }
    
    my $flags = fcntl($fh, F_GETFL, 0) or die "can't fcntl F_GETFL: $!";
    my $mode = '';
    if ( defined($flags) ) {
        if (($flags & O_ACCMODE) == O_RDONLY ) {
            $mode = 'r'
        }
        if (($flags & O_ACCMODE) == O_WRONLY ) {
            $mode = 'w'
        }
        if (($flags & O_ACCMODE) == O_RDWR ) {
            $mode = 'rw'
        }
    }
    return $mode;
}

method flush() {
    if( !defined $self->fh ) {
      $self->throw("Attempting to call flush but no filehandle active");
    }
    $self->fh->flush();
}

method close() {
    # don't close if we explictly asked not to
    return if $self->no_close;

    if( defined( my $fh = $self->fh )) {
        $self->flush;
        return if     ref $fh eq 'GLOB'
          && (    \*STDOUT == $fh
               || \*STDERR == $fh
               || \*STDIN  == $fh
                     );        
        close $fh unless ref $fh && $fh->isa('IO::String');
    }
}

no Moose::Role;

1;

