module external.core.fiber;

import core.thread.context: StackContext;
version (LDC) import ldc.attributes;
import core.demangle: mangleFunc;

extern(C) void fiber_entryPoint() nothrow;

pragma(mangle, mangleFunc!(void function(StackContext*) nothrow @nogc)("core.thread.fiber.initFreestandingStack"))
export void initFreestandingStack(StackContext* m_ctxt) nothrow @nogc
{
    import core.thread.types: isStackGrowingDown;

    initStack!isStackGrowingDown(m_ctxt);
}

version (ARM)
{
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
}
else version (RISCV32)
{
    void initStack(bool isStackGrowingDown)(StackContext* m_ctxt) nothrow @nogc
    {
        static assert(isStackGrowingDown);

        assert(false, "FIXME: implement");
    }

    extern (C) void fiber_switchContext( void** oldp, void* newp ) nothrow @nogc
    {
        assert(false, "FIXME: fiber_switchContext not implemented");
    }
}
