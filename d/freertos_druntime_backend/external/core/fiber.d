module external.core.fiber;

version (LDC) import ldc.attributes;

final void initStack() nothrow @nogc
{
    assert(false, "Not implemented");
}

export void fiber_entryPoint() nothrow /* LDC */ @assumeUsed @nogc
{
    assert(false, "Not implemented");
}

//TODO: Deprecated
extern (C) void fiber_switchContext( void** oldp, void* newp ) nothrow @nogc
{
    assert(false, "Not implemented");
}

version (ARM)
{
    import core.stdc.config: c_ulong;

    void swapcontext(ucontext_t* oldp, ucontext_t* newp) nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    struct sigcontext
    {
        c_ulong trap_no;
        c_ulong error_code;
        c_ulong oldmask;
        c_ulong arm_r0;
        c_ulong arm_r1;
        c_ulong arm_r2;
        c_ulong arm_r3;
        c_ulong arm_r4;
        c_ulong arm_r5;
        c_ulong arm_r6;
        c_ulong arm_r7;
        c_ulong arm_r8;
        c_ulong arm_r9;
        c_ulong arm_r10;
        c_ulong arm_fp;
        c_ulong arm_ip;
        c_ulong arm_sp;
        c_ulong arm_lr;
        c_ulong arm_pc;
        c_ulong arm_cpsr;
        c_ulong fault_address;
    }

    alias mcontext_t = sigcontext;

    struct stack_t
    {
        void*   ss_sp;
        size_t  ss_size;
        int     ss_flags;
    }

    struct sigset_t
    {
        uint[4] __bits;
    }

    struct ucontext_t
    {
        c_ulong uc_flags;
        ucontext_t* uc_link;
        stack_t uc_stack;
        mcontext_t uc_mcontext;
        sigset_t uc_sigmask;
        align(8) c_ulong[128] uc_regspace;
    }
}
