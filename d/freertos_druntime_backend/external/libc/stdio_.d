module external.libc.stdio_;

import external.libc.config;

///
alias c_long fpos_t;

///
struct FILE;

__gshared extern(C) extern FILE*[3] __iob;

__gshared FILE* stdin;
__gshared FILE* stdout;
__gshared FILE* stderr;

shared static this()
{
    stdin  = __iob[0];
    stdout = __iob[1];
    stderr = __iob[2];
}

enum
{
    ///
    _IOFBF = 0,
    ///
    _IOLBF = 1,
    ///
    _IONBF = 2,
}

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

extern(C) int snprintf(scope char* s, size_t n, scope const char* format, ...) nothrow @nogc;
