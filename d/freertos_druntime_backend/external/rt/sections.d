module  external.rt.sections;

void[] externalInitTLSRanges() nothrow @nogc
{
    assert(false, "not implemented");
}

import rt.sections_ldc : SectionGroup;

// These values described in linker script
private extern (C) extern __gshared void* _data;
private extern (C) extern __gshared void* _etbss;

void fillGlobalSectionGroup(ref SectionGroup gsg) nothrow @nogc
{
    // Writeable data segments covered by GC, from .data to end of .tbss
    size_t size = _etbss - _data;

    gsg._gcRanges.insertBack(_data[0 .. size]);
}

extern(C) void* __tls_get_addr(void*) nothrow @nogc
{
    assert(false, "not implemented");
}
