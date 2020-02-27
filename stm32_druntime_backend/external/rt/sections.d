module  external.rt.sections;

void[]* initTLSRanges() nothrow @nogc
{
    assert(false, "not implemented");
}

void finiTLSRanges(void[]* rng) nothrow @nogc
{
    assert(false, "not implemented");
}

void scanTLSRanges(void[]* rng, scope void delegate(void* pbeg, void* pend) nothrow dg) nothrow
{
    assert(false, "not implemented");
}

void initSections() nothrow @nogc
{
    assert(false, "not implemented");
}

void finiSections() nothrow @nogc
{
    assert(false, "not implemented");
}

struct SectionGroup
{
    import rt.minfo;
    import external.rt.deh;

    static int opApply(scope int delegate(ref SectionGroup) dg)
    {
        return dg(_sections);
    }

    static int opApplyReverse(scope int delegate(ref SectionGroup) dg)
    {
        return dg(_sections);
    }

    @property immutable(ModuleInfo*)[] modules() const nothrow @nogc
    {
        return _moduleGroup.modules;
    }

    @property ref inout(ModuleGroup) moduleGroup() inout nothrow @nogc
    {
        return _moduleGroup;
    }

    @property immutable(FuncTable)[] ehTables() const nothrow @nogc
    {
        auto pbeg = cast(immutable(FuncTable)*)&__start_deh;
        auto pend = cast(immutable(FuncTable)*)&__stop_deh;
        return pbeg[0 .. pend - pbeg];
    }

    @property inout(void[])[] gcRanges() inout nothrow @nogc
    {
        return _gcRanges[];
    }

private:
    ModuleGroup _moduleGroup;
    void[][1] _gcRanges;
}
