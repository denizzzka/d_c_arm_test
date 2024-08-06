C + D + FreeRTOS
cross-compilation for
bare metal devices
=====================

Prerequisites:

- Installed: dub, ldc2 (v1.40 or newer), clang-18 (or newer), libclang1-10 (used by dpp), gcc-arm-none-eabi (provides libgcc.a)

PREBUILD:

$ dub fetch dpp # d++, headers parser

BUILD STEPS:

1. Build DFRuntime as described in https://github.com/denizzzka/dfruntime

2. Then cd into current repository and:

$ meson setup --cross-file ../dfruntime/meson/arm_cortex_m4_cross.ini --cross-file arm_cortex_m4_cross.ini --optimization=s builddir
$ cd build
$ ninja

This steps will produce file firmware.elf: "ELF 32-bit LSB executable,
ARM, EABI5 version 1 (SYSV), statically linked, with debug_info,
not stripped".

BUILD using docker (FIXME: broken)

cd into this repository and:

$ docker build -t d_c_arm_test .
$ docker create -ti --name dummy d_c_arm_test bash && docker cp dummy:/tmp/project/build/firmware.elf firmware.elf && docker rm -f dummy

TODO:

- Please see Github "Issues" section
