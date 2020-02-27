module libc.errno;

extern (C)
{
    ref int __error();
    alias errno = __error;
}
