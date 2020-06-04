module external.rt.sections;

import rt.sections_ldc : SectionGroup;
debug(PRINTF) import core.stdc.stdio : printf;

// These values described in linker script
extern(C) extern __gshared void* _data;
extern(C) extern __gshared void* _ebss;

extern(C) extern __gshared void* _tdata;
extern(C) extern __gshared void* _tbss;
extern(C) extern __gshared void* _tbss_size;

struct TLSParams
{
    void* tdata_start;
    size_t tdata_size;
    void* tbss_start;
    size_t tbss_size;
    size_t full_tls_size;
}

TLSParams getTLSParams() nothrow @nogc
{
    auto tdata_start = cast(void*)&_tdata;
    auto tbss_start = cast(void*)&_tbss;
    size_t tdata_size = tbss_start - tdata_start;
    size_t tbss_size = cast(size_t)&_tbss_size;
    size_t full_tls_size = tdata_size + tbss_size;

    assert(tbss_size > 1);

    return TLSParams(
        tdata_start,
        tdata_size,
        tbss_start,
        tbss_size,
        full_tls_size
    );
}

extern(C) void _set_tls(void*) nothrow @nogc; // Provided by picolibc
extern(C) void* __aeabi_read_tp() nothrow @nogc; // Provided by picolibc

extern(C) void* __tls_get_addr() nothrow @nogc
{
    return __aeabi_read_tp();
}

void fillGlobalSectionGroup(ref SectionGroup gsg) nothrow @nogc
{
    debug(PRINTF) printf(__FUNCTION__~" called\n");

    // Writeable (non-TLS) data sections covered by GC
    auto data_start = cast(void*)&_data;
    ptrdiff_t size = cast(void*)&_ebss - data_start;

    gsg._gcRanges.insertBack(data_start[0 .. size]);

    debug(PRINTF) printf(__FUNCTION__~" done\n");
}

/***
 * Called once per thread; returns array of thread local storage ranges
 */
void[] initTLSRanges() nothrow @nogc
{
    import external.core.thread;

    debug(PRINTF) printf("external initTLSRanges called\n");

    import core.stdc.string: memcpy, memset;

    auto p = getTLSParams;

    // Allocate TLS memory
    static import core.stdc.stdlib;
    void* tls = core.stdc.stdlib.malloc(p.full_tls_size);

    // Set up TLS pointer
    _set_tls(tls);

    auto curr_thread = Thread.getThis;
    // Copying TLS data
    memcpy(tls, p.tdata_start, p.tdata_size);

    // Init local bss by zeroes
    memset(tls + p.tdata_size, 0x00, p.tbss_size);

    debug(PRINTF) printf("external initTLSRanges done\n");

    return null; //p.tdata_dst[0 .. p.full_tls_size];
}
