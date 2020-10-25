module arm_cortex_debug;

version (LDC):
version (ARM_Thumb):

nothrow:
@nogc:

import ldc.attributes;
import ldc.llvmasm;

version(ARM):

extern(C) void hard_fault_handler() @naked @assumeUsed { hardFaultHandler; }
extern(C) void usage_fault_handler() @naked @assumeUsed { hardFaultHandler; }
extern(C) void mem_manage_handler() @naked @assumeUsed { hardFaultHandler; }

__gshared Registers regs;

extern(C) void hardFaultHandler() @naked
{
    // Get fault stack address
    regs.sp = __asm!(void*)(`
        tst lr, #4      // check 3 bit
        ite eq          // (bit == 1)
        mrseq $0, msp   // ? main stack pointer is used, save it
        mrsne $0, msp //FIXME:here is something is broken, must be psp   // : process stack pointer is used, save it
        `,
        `=&r`,
    );

    import ldc.intrinsics;
    regs.other = *(cast(InterruptStackFrame*) llvm_frameaddress(0));

    regs.sp += InterruptStackFrame.sizeof;

    while(true)
        llvm_debugtrap();
}

struct InterruptStackFrame
{
    uint r0;
    uint r1;
    uint r2;
    uint r3;
    uint r12;
    void* lr;    /// Link register
    void* pc;    /// Program counter
    uint psr;    /// Program status register
}

struct Registers
{
    void* sp;

    InterruptStackFrame other;
    alias other this;
}

void doHardFault()
{
    __asm!()(`
        LDR R1, =0x0800029A;
        BX r1;
        `,
        ``,
    );
}
