module  external.rt.sections;

void[] externalInitTLSRanges() nothrow @nogc
{
    assert(false, "not implemented");
}

import rt.sections_ldc : SectionGroup;

// These values described in linker script
extern(C) extern __gshared void* _data;
extern(C) extern __gshared void* _ebss;

void fillGlobalSectionGroup(ref SectionGroup gsg) nothrow @nogc
{
    // Writeable data segments covered by GC, from .data to end of .tbss
    auto data_start = cast(void*)&_data;
    ptrdiff_t size = cast(void*)&_ebss - data_start;

    gsg._gcRanges.insertBack(data_start[0 .. size]);
}

extern(C) void* __tls_get_addr(void*) nothrow @nogc
{
    assert(false, "not implemented");
}
