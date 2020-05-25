module external.libc.errno;

@nogc:
nothrow:

extern (C) ref int __error()
{
    assert(false, "Not implemented");
}

alias errno = __error;

enum EINTR =  4;       /// interrupted system call
