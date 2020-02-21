C + D + FreeRTOS
cross-compilation for
bare metal devices
=====================

Prerequisites:

- Installed: dub, ldc2, arm-none-eabi-gcc

PREBUILD:

$ dub fetch dpp # d++, headers parser

BUILD STEPS:

cd into this repository and:

$ meson setup --cross-file arm_cortex_m3_cross.ini builddir
$ cd builddir
$ ninja

This steps will produce file firmware.elf: "ELF 32-bit LSB executable,
ARM, EABI5 version 1 (SYSV), statically linked, with debug_info,
not stripped".

TODO:

- Cover libopencm3 by Meson (only dirty workaround is implemented)
- Cover FreeRTOS by Meson (ditto)
