module external.libc.config;

version(D_LP64)
    version = Is64bit;
version(D_X32)
    version = Is64bit;

version(Is64bit)
{
    alias c_long = long;
    alias c_ulong = ulong;
}
else
{
    alias c_long = int;
    alias c_ulong = uint;
}
