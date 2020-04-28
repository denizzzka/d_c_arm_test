module libc.errno;

@nogc:
nothrow:

extern (C)
{
    ref int __error();
    alias errno = __error;
}
