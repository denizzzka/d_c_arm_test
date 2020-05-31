module  external.rt.sections;

import rt.sections_ldc : SectionGroup;
debug(PRINTF) import core.stdc.stdio : printf;

// These values described in linker script
extern(C) extern __gshared void* _data;
extern(C) extern __gshared void* _ebss;

extern(C) extern __gshared void* _tdata;
extern(C) extern __gshared void* _tbss;
extern(C) extern __gshared void* _etbss;

extern(C) void _set_tls(void*) nothrow @nogc; // Provided by picolibc

void fillGlobalSectionGroup(ref SectionGroup gsg) nothrow @nogc
{
    debug(PRINTF) printf(__FUNCTION__~" called\n");

    // Writeable data sections covered by GC
    auto data_start = cast(void*)&_data;
    ptrdiff_t size = cast(void*)&_ebss - data_start;

    gsg._gcRanges.insertBack(data_start[0 .. size]);

    // TLS data sections
    auto tdata_start = cast(void*)&_tdata;
    _set_tls(tdata_start);
    gsg._tlsSize = cast(void*)&_etbss - tdata_start;

    // Init .tbss by zeroes (.bss already initialized by libopencm3)
    auto tbss_start = cast(ubyte*)&_tbss;
    auto tbss_size = cast(ubyte*)&_etbss - tbss_start;
    foreach(i; 0 .. tbss_size)
        tbss_start[i] = 0x00;

    debug(PRINTF) printf(__FUNCTION__~" done\n");
}

/***
 * Called once per thread; returns array of thread local storage ranges
 */
void[] initTLSRanges() nothrow @nogc
{
    assert(false, "not implemented");
}
