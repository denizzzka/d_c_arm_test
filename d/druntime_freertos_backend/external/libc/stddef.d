module external.libc.stddef;

//~ alias wchar_t = dchar;

// fenv.d content:
struct fenv_t
{
    c_ulong __cw;
}

import core.stdc.config: c_ulong;
alias fexcept_t = c_ulong;

enum FE_DFL_ENV = cast(fenv_t*)(-1);
