module arm_cortex_debug;

version (LDC):

import ldc.attributes;

version(ARM):

//~ alias Handler = extern (C) void function() nothrow @nogc;

//~ shared static this()
//~ {
	//~ Handler vector_hardFault_ptr = cast(Handler) (cast(size_t*) 0x00)[3];

	//~ vector_hardFault_ptr = &hardFaultHandler;
//~ }

extern(C) void mem_manage_handler() nothrow @nogc @naked @assumeUsed
{
    import ldc.llvmasm;

    __asm!()(`
    tst lr, #4
    ite eq
    mrseq r0, msp
    mrsne r0, psp
    ldr r1, [r0, #24]
    ldr r2, handler2_address_const
    bx r2
    handler2_address_const: .word prvGetRegistersFromStack
    `,
    ``
    );
}

struct Registers
{
	uint r0;
	uint r1;
	uint r2;
	uint r3;
	uint r12;
	uint lr; /* Link register. */
	uint pc; /* Program counter. */
	uint psr;/* Program status register. */
}

extern(C) void prvGetRegistersFromStack(uint* pulFaultStackAddress)
{
	Registers regs;
	with(regs)
	{
		r0 = pulFaultStackAddress[ 0 ];
		r1 = pulFaultStackAddress[ 1 ];
		r2 = pulFaultStackAddress[ 2 ];
		r3 = pulFaultStackAddress[ 3 ];

		r12 = pulFaultStackAddress[ 4 ];
		lr = pulFaultStackAddress[ 5 ];
		pc = pulFaultStackAddress[ 6 ];
		psr = pulFaultStackAddress[ 7 ];
	}

    while(true){}
}
