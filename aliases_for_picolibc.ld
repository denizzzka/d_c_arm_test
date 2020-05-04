__bss_start__ = ADDR(.bss);
PROVIDE(__bss_end__ = _ebss);
PROVIDE(__bss_end = __bss_end__);

/* copied from picolibc.ld: */
	PROVIDE( __end = __bss_end );
	PROVIDE( _end = __bss_end );
	PROVIDE( end = __bss_end );
	PROVIDE(__bss_size = __bss_end - __bss_start);

	PROVIDE( __heap_end = ORIGIN(ram) + LENGTH(ram) - (DEFINED(__stack_size) ? __stack_size : 0x800));
	PROVIDE( __heap_size = __heap_end - __bss_end );
