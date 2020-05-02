module libc.errno;

@nogc:
nothrow:

extern (C) ref int __error()
{
    assert(false, "Not implemented");
}

alias errno = __error;
