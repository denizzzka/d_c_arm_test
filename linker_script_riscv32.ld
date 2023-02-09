EXTERN(vector_table)
ENTRY(reset_handler)
MEMORY
{
/* flash (rx) : ORIGIN = 0x00000000, LENGTH = 256K */
 rom (rx)   : ORIGIN = 0x08000000, LENGTH = 512K
 ram (rwx)  : ORIGIN = 0x20000000, LENGTH = 128K
}
SECTIONS
{
  /* fake output .got section */
  /* Dynamic relocations are unsupported. This section is only used to detect
     relocatable code in the input files and raise an error if relocatable code
     is found */
  .got :
  {
    _sgot = .;
    KEEP(*(.got .got.*));
    _egot = .;
  } >ram

 .vectors : {
  *(.vectors)
 } >rom
 .text : {
  *(.text*)
  . = ALIGN(4);
  *(.rodata*)
  . = ALIGN(4);
 } >rom
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
 .ARM.extab : {
  *(.ARM.extab*)
 } >rom
 .ARM.exidx : {
  __exidx_start = .;
  *(.ARM.exidx*)
  __exidx_end = .;
 } >rom
 .eh_frame : {
  __eh_frame_start = .;
  *(.eh_frame)
  __eh_frame_end = .;
  . = ALIGN(4);
 } >rom
 .eh_frame_hdr : {
  __eh_frame_hdr_start = .;
  *(.eh_frame_hdr)
  __eh_frame_hdr_end = .;
 } >rom
 . = ALIGN(4);
 _etext = .;
 .tdata : {
  PROVIDE( _tdata = .);
  *(.tdata .tdata.* .gnu.linkonce.td.*)
  . = ALIGN(4);
 } >rom :tls :ram_init
 _tdata_size = SIZEOF(.tdata);
 .tbss : {
  PROVIDE( _tbss = . );
  *(.tbss .tbss.* .gnu.linkonce.tb.*)
  *(.tcommon)
  PROVIDE( _etbss = . );
  . = ALIGN(4);
 } >rom :tls
 _tbss_size = SIZEOF(.tbss);
 .data : {
  _data = .;
  *(.data*)
  . = ALIGN(4);
  _edata = .;
 } >ram AT >rom
 _data_loadaddr = LOADADDR(.data);
 .bss : {
  *(.bss*)
  *(COMMON)
  . = ALIGN(4);
  _ebss = .;
 } >ram
 . = ALIGN(4);
 end = .;

 .stack :
 {
   __stack_bottom = .;
   __stack_top = ORIGIN(ram) + LENGTH(ram);
   __freertos_irq_stack_top = __stack_top;
   __stack_size_min = 0x4000;
   ASSERT(__stack_bottom + __stack_size_min < __stack_top, "Error: no space for stack");
 }
}

PROVIDE( __heap_start = end );
PROVIDE( __heap_end = ORIGIN(ram) + LENGTH(ram) - 0x800 );
