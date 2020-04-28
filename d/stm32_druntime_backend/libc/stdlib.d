module libc.stdio;

union fpos_t
{
    char[16] __opaque = 0;
    double __align;
}
struct _IO_FILE;

///
alias _iobuf = _IO_FILE; // needed for phobos
///
alias FILE = shared(_IO_FILE);

enum
{
    ///
    BUFSIZ       = 4096,
    ///
    EOF          = -1,
    ///
    FOPEN_MAX    = 16,
    ///
    FILENAME_MAX = 4095,
    ///
    TMP_MAX      = 238328,
    ///
    L_tmpnam     = 20
}

enum RAND_MAX = 0x7fffffff;

void*   realloc(void* ptr, size_t size);
