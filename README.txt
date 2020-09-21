C + D + FreeRTOS
cross-compilation for
bare metal devices
=====================

Prerequisites:

- Installed: dub, ldc2, clang-11, libclang1-10 (used by dpp), gcc-arm-none-eabi

PREBUILD:

$ dub fetch dpp # d++, headers parser

BUILD STEPS:

cd into this repository and:

$ meson setup --cross-file arm_cortex_m3_cross.ini build
$ cd build
$ ninja

This steps will produce file firmware.elf: "ELF 32-bit LSB executable,
ARM, EABI5 version 1 (SYSV), statically linked, with debug_info,
not stripped".

TODO:

- Please see Github "Issues" section
