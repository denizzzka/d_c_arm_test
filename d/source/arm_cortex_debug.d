module arm_cortex_debug;

version (LDC):
version (ARM_Thumb):

/* --- ARM Cortex-M0, M3 and M4 specific definitions ----------------------- */
/* Private peripheral bus - Internal */
//FIXME: get from libopencm3
enum PPBI_BASE = 0xE0000000U;
enum SCS_BASE = PPBI_BASE + 0xE000;
enum SCB_BASE = SCS_BASE + 0x0D00;

/** CFSR: Configurable Fault Status Registers */
enum SCB_CFSR = SCB_BASE + 0x28;

/** HFSR: Hard Fault Status Register */
enum SCB_HFSR = SCB_BASE + 0x2C;

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

    regs.hfsr = *(cast(HFSR*) SCB_HFSR);
    regs.cfsr = *(cast(CFSR*) SCB_CFSR);

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
    InterruptStackFrame other;
    alias other this;

    void* sp;

    HFSR hfsr; /// Hard Fault Status Register
    CFSR cfsr; /// Configurable Fault Status Registers
}

import std.bitmanip;

struct HFSR
{
    mixin(bitfields!(
        bool, "reserved", 1,
        bool, "VECTTBL",  1,
        uint, "reserved", 28,
        bool, "FORCED",   1,
        bool, "DEBUGEVT", 1,
    ));
}

struct CFSR
{
    mixin(bitfields!(
        // MMFSR
        bool, "MMFSR_IACCVIOL", 1,
        bool, "MMFSR_DACCVIOL", 1,
        bool, "MMFSR_reserved", 1,
        bool, "MMFSR_MUNSTKERR", 1,
        bool, "MMFSR_MSTKERR", 1,
        ushort, "MMFSR_reserved", 2,
        bool, "MMFSR_MMARVALID", 1,

        // BFSR
        bool, "BFSR_IBUSERR", 1,
        bool, "BFSR_PRECISERR", 1,
        bool, "BFSR_IMPRECISERR", 1,
        bool, "BFSR_UNSTKERR", 1,
        bool, "BFSR_STKERR", 1,
        ushort, "BFSR_reserved", 2,
        bool, "BFSR_BFARVALID", 1,

        // UFSR
        bool, "UFSR_UNDEFINSTR", 1,
        bool, "UFSR_INVSTATE", 1,
        bool, "UFSR_INVPC", 1,
        bool, "UFSR_NOCP", 1,
        ubyte, "UFSR_reserved0", 4,
        bool, "UFSR_UNALIGNED", 1,
        bool, "UFSR_DIVBYZERO", 1,
        ubyte, "UFSR_reserved1", 6,
    ));
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
