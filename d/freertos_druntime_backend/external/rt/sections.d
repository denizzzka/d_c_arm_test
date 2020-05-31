module  external.rt.sections;

import rt.sections_ldc : SectionGroup;

// These values described in linker script
extern(C) extern __gshared void* _data;
extern(C) extern __gshared void* _ebss;

extern(C) extern __gshared void* _tdata;
extern(C) extern __gshared void* _etbss;

void fillGlobalSectionGroup(ref SectionGroup gsg) nothrow @nogc
{
    // Writeable data sections covered by GC
    auto data_start = cast(void*)&_data;
    ptrdiff_t size = cast(void*)&_ebss - _data;

    gsg._gcRanges.insertBack(data_start[0 .. size]);

    // TLS data sections
    gsg._tlsSize = cast(void*)&_etbss - _tdata;
}

/***
 * Called once per thread; returns array of thread local storage ranges
 */
void[] initTLSRanges() nothrow @nogc
{
    assert(false, "not implemented");
}
