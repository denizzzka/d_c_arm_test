module libc.stdio_;

import libc.config;

///
alias c_long fpos_t;

///
struct _iobuf
{
    char* _ptr;
    int   _cnt;
    char* _base;
    int   _flag;
    int   _file;
    int   _charbuf;
    int   _bufsiz;
    char* __tmpnum;
}

///
alias FILE = shared(_iobuf);

enum
{
    ///
    _IOFBF = 0,
    ///
    _IOLBF = 1,
    ///
    _IONBF = 2,
}

export shared FILE* stdin;
export shared FILE* stdout;
export shared FILE* stderr;

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

export int snprintf(scope char* s, size_t n, scope const char* format, ...) nothrow @nogc
{
    assert(false, "not implemented");
}
