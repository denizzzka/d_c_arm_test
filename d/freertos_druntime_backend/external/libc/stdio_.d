module external.libc.stdio_;

import external.libc.config;

///
alias c_long fpos_t;

///
struct FILE;

__gshared FILE* stdin;
__gshared FILE* stdout;
__gshared FILE* stderr;

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
