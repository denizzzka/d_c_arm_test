module  external.rt.sections;

void[] externalInitTLSRanges() nothrow @nogc
{
    assert(false, "not implemented");
}

extern(C) void* __tls_get_addr(void*) nothrow @nogc
{
    assert(false, "not implemented");
}
