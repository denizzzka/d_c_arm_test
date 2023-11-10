module external.core.memory;

import core.demangle : mangle;

pragma(mangle, mangle!(immutable size_t)("core.memory.pageSize"))
export immutable size_t pageSize = 4096;
