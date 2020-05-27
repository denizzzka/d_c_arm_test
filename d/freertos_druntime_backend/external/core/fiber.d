module external.core.fiber;

version (LDC) import ldc.attributes;

version (ARM):

final void initStack() nothrow @nogc
{
    assert(false, "Not implemented");
}

export void fiber_entryPoint() nothrow /* LDC */ @assumeUsed @nogc
{
    assert(false, "Not implemented");
}

extern (C) void fiber_switchContext(size_t** for_store_curr_sp, size_t* switch_to_sp) nothrow @nogc @naked
{
	import ldc.llvmasm;

	__asm!()(`
	// stack grows down (sp is decrementing while grow)
	PUSH    {r0-r12}                @ Push user registers (except two what contain arguments)

	@FIXME:
    @MRS     r0, SPSR                @ Pick up Saved Program Status Register
    PUSH    {r0, lr}                @ and push it with return address.

	LDRH	r1, [$0]                @ Get pointer to storage ptr
	MRS		r2, psp                 @ Get and
	STRH	r2, [r1]                @ store sp value into storage

    LDRH    r3, [$1]                @ Load new process sp from switch_to_sp argument
	MSR		psp, r3                 @ Set up new sp value

    POP     {r0, lr}                @ Pop SPSR data
    @MSR     SPSR_cxsf, r0           @ and restore some SPSR fields.

    POP     {r0-r12}                @ Pop the rest of the registers

	BX      lr						@ Return (also sets PC to new value)
	`,
	"r,r",
	for_store_curr_sp, switch_to_sp);
}
