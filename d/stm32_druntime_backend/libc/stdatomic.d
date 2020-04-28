module libc.stdatomic;

import core.atomic : MemoryOrder;

bool atomicCompareExchangeStrongNoResult(MemoryOrder succ = MemoryOrder.seq, MemoryOrder fail = MemoryOrder.seq, T)(T* dest, const T compare, T value) pure nothrow @nogc @trusted
{
    assert(false, "not implemented");
}

T atomicFetchAdd(MemoryOrder order = MemoryOrder.seq, bool result = true, T)(T* dest, T value) pure nothrow @nogc @trusted
{
    assert(false, "not implemented");
}

T atomicFetchSub(MemoryOrder order = MemoryOrder.seq, bool result = true, T)(T* dest, T value) pure nothrow @nogc @trusted
{
    assert(false, "not implemented");
}

inout(T) atomicLoad(MemoryOrder order = MemoryOrder.seq, T)(inout(T)* src) pure nothrow @nogc @trusted
{
    assert(false, "not implemented");
}

void atomicStore(MemoryOrder order = MemoryOrder.seq, T)(T* dest, T value) pure nothrow @nogc @trusted
{
}
