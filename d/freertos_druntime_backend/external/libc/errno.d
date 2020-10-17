module external.libc.errno;

@nogc:
nothrow:

extern(C) extern __gshared int errno;

extern (C) ref int __error() @system
{
    return errno;
}
