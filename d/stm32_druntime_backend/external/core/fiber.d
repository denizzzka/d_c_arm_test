module external.core.fiber;

version (LDC) import ldc.attributes;

final void initStack() nothrow @nogc
{
    assert(false, "Not implemented");
}

export void fiber_entryPoint() nothrow /* LDC */ @assumeUsed
{
    assert(false, "Not implemented");
}

export void fiber_switchContext( void** oldp, void* newp ) nothrow @nogc
{
    assert(false, "Not implemented");
}
