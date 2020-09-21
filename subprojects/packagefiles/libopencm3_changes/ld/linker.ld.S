/*
 * This file is part of the libopencm3 project.
 *
 * Copyright (C) 2009 Uwe Hermann <uwe@hermann-uwe.de>
 * Copyright (C) 2013 Frantisek Burian <BuFran@seznam.cz>
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library.  If not, see <http://www.gnu.org/licenses/>.
 */

/* Generic linker script for all targets using libopencm3. */

/* Enforce emmition of the vector table. */
EXTERN(vector_table)

/* Define the entry point of the output file. */
ENTRY(reset_handler)

/* Define memory regions. */
MEMORY
{
	/* RAM is always used */
	ram (rwx) : ORIGIN = _RAM_OFF, LENGTH = _RAM

#if defined(_ROM)
	rom (rx) : ORIGIN = _ROM_OFF, LENGTH = _ROM
#endif
#if defined(_ROM1)
	rom1 (rx) : ORIGIN = _ROM1_OFF, LENGTH = _ROM1
#endif
#if defined(_ROM2)
	rom2 (rx) : ORIGIN = _ROM2_OFF, LENGTH = _ROM2
#endif
#if defined(_RAM1)
	ram1 (rwx) : ORIGIN = _RAM1_OFF, LENGTH = _RAM1
#endif
#if defined(_RAM2)
	ram2 (rwx) : ORIGIN = _RAM2_OFF, LENGTH = _RAM2
#endif
#if defined(_RAM3)
	ram3 (rwx) : ORIGIN = _RAM3_OFF, LENGTH = _RAM3
#endif
#if defined(_CCM)
	ccm (rwx) : ORIGIN = _CCM_OFF, LENGTH = _CCM
#endif
#if defined(_EEP)
	eep (r) : ORIGIN = _EEP_OFF, LENGTH = _EEP
#endif
#if defined(_XSRAM)
	xsram (rw) : ORIGIN = _XSRAM_OFF, LENGTH = _XSRAM
#endif
#if defined(_XDRAM)
	xdram (rw) : ORIGIN = _XDRAM_OFF, LENGTH = _XDRAM
#endif
#if defined(_NFCRAM)
	nfcram (rw) : ORIGIN _NFCRAM_OFF, LENGTH = _NFCRAM
#endif
}

/* Define sections. */
SECTIONS
{
	.text : {
		*(.vectors)	/* Vector table */
		*(.text*)	/* Program code */
		. = ALIGN(4);
		*(.rodata*)	/* Read-only data */
		. = ALIGN(4);
	} >rom

	/* C++ Static constructors/destructors, also used for
	 * __attribute__((constructor)) and the likes.
	 */
	.preinit_array : {
		. = ALIGN(4);
		__preinit_array_start = .;
		KEEP (*(.preinit_array))
		__preinit_array_end = .;
	} >rom
	.init_array : {
		. = ALIGN(4);
		__init_array_start = .;
		KEEP (*(SORT(.init_array.*)))
		KEEP (*(.init_array))
		__init_array_end = .;
	} >rom
	.fini_array : {
		. = ALIGN(4);
		__fini_array_start = .;
		KEEP (*(.fini_array))
		KEEP (*(SORT(.fini_array.*)))
		__fini_array_end = .;
	} >rom

	/*
	 * Another section used by C++ stuff, appears when using newlib with
	 * 64bit (long long) printf support
	 */
	.ARM.extab : {
		*(.ARM.extab*)
	} >rom
	.ARM.exidx : {
		__exidx_start = .;
		*(.ARM.exidx*)
		__exidx_end = .;
	} >rom

	.eh_frame : {
		__eh_frame_start = .; /* used by libunwind */
		*(.eh_frame)
		__eh_frame_end = .; /* used by libunwind */
		. = ALIGN(4);
	} >rom

	.eh_frame_hdr : {
		__eh_frame_hdr_start = .; /* used by libunwind */
		*(.eh_frame_hdr)
		__eh_frame_hdr_end = .; /* used by libunwind */
	} >rom

	. = ALIGN(4);
	_etext = .;

	/* Thread local initialized data. This gets
	 * space allocated as it is expected to be placed
	 * in ram to be used as a template for TLS data blocks
	 * allocated at runtime. We're slightly abusing that
	 * by placing the data in flash where it will be copied
	 * into the allocate ram addresses by the existing
	 * data initialization code in crt0
	 */
	.tdata : {
		PROVIDE( _tdata = .);
		*(.tdata .tdata.* .gnu.linkonce.td.*)
		. = ALIGN(4);
	} >ram AT>rom :tls :ram_init

	.tbss : {
		PROVIDE( _tbss = . );
		*(.tbss .tbss.* .gnu.linkonce.tb.*)
		*(.tcommon)
		PROVIDE( _etbss = . );
		. = ALIGN(4);
	} >ram AT>ram :tls :ram
	_tbss_size = SIZEOF(.tbss);

	.data : {
		_data = .;
		*(.data*)	/* Read-write initialized data */
		. = ALIGN(4);
		_edata = .;
	} >ram AT >rom
	_data_loadaddr = LOADADDR(.data);

	.bss : {
		*(.bss*)	/* Read-write zero initialized data */
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
	} >ram

#if defined(_CCM)
	.ccm : {
		*(.ccmram*)
		. = ALIGN(4);
	} >ccm
#endif

#if defined(_RAM1)
	.ram1 : {
		*(.ram1*)
		. = ALIGN(4);
	} >ram1
#endif

#if defined(_RAM2)
	.ram2 : {
		*(.ram2*)
		. = ALIGN(4);
	} >ram2
#endif

#if defined(_RAM3)
	.ram3 : {
		*(.ram3*)
		. = ALIGN(4);
	} >ram3
#endif

#if defined(_XSRAM)
	.xsram : {
		*(.xsram*)
		. = ALIGN(4);
	} >xsram
#endif

#if defined(_XDRAM)
	.xdram : {
		*(.xdram*)
		. = ALIGN(4);
	} >xdram
#endif

#if defined(_NFCRAM)
	.nfcram : {
		*(.nfcram*)
		. = ALIGN(4);
	} >nfcram
#endif
	. = ALIGN(4);
	end = .;
}

PROVIDE(_stack = ORIGIN(ram) + LENGTH(ram));

/* Additions for picolibc: */
PROVIDE( __heap_start = end );
PROVIDE( __heap_end = ORIGIN(ram) + LENGTH(ram) - 0x800 /* stack size */);
