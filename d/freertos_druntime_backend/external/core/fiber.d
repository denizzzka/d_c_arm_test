module external.core.fiber;

version (LDC) import ldc.attributes;

version (ARM):

import core.thread.context: StackContext;

extern(C) void fiber_entryPoint() nothrow;

void initStack(bool isStackGrowingDown)(StackContext* m_ctxt) nothrow @nogc
if(isStackGrowingDown)
{
    void* pstack = m_ctxt.tstack;
    scope(exit) m_ctxt.tstack = pstack;

    void push( size_t val ) nothrow
    {
        pstack -= size_t.sizeof;
        *(cast(size_t*) pstack) = val;
    }

    pstack -= int.sizeof * 8;

    // link register
    push( cast(size_t) &fiber_entryPoint );

    /*
     * We do not push padding and d15-d8 as those are zero initialized anyway
     * Position the stack pointer above the lr register
     */
    pstack += int.sizeof;
}
