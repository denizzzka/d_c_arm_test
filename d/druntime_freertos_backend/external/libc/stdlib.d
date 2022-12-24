module external.libc.stdlib;

nothrow @nogc:

enum RAND_MAX = 0x7fffffff;

extern(C) void* aligned_alloc(size_t _align, size_t size);
