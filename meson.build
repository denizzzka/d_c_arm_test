project(
    'C + D + FreeRTOS test project',
    ['d', 'c', 'cpp'],
    version: 'v0.0.1',
    default_options: [
        'default_library=static', #move out it
        'b_staticpic=false',
    ]
)

#TODO: keep until will not be fixed https://github.com/mesonbuild/meson/issues/7154
if get_option('dlang_lto')
    lto_type = 'full'
    lto_d = '--flto=' + lto_type #saves ~100KB
else
    lto_d = ''
endif

#FIXME: replace by imports
ldc_default_libs_links = meson.source_root() / 'subprojects' / 'druntime' / 'src'

add_global_arguments(
    lto_d,
    '--conf=' + meson.current_source_dir()/'baremetal_ldc2.conf', #Required for override of system Phobos instance. Phobos binary usually isn't provided for target platform, but Phobos is need to initialize Meson
    '-I' + ldc_default_libs_links,
    #'--boundscheck=off', #saves 1.4KB
    #TODO: remove these "--d-version" - used only for Phobos headers compilation:
    '--d-version=DruntimeAbstractRt',
    '--d-version=GENERIC_IO',
    language: 'd'
)
add_global_link_arguments(
    '-Xlinker', '--fatal-warnings',
    language: 'c'
)
add_global_link_arguments(
    lto_d,
    '-L=--fatal-warnings',
    language: 'd'
)

picolibc_sub = subproject(
    'picolibc',
    default_options: [
        'multilib=false',
        'newlib-global-errno=true',
        'newlib-io-c99-formats=true',
        'newlib-long-time_t=true',
        'newlib-multithread=true',
        'tinystdio=true',
        'thread-local-storage=false',
    ]
)
picolibc_dep = picolibc_sub.get_variable('picolibc_dep')
semihost_lib = picolibc_sub.get_variable('lib_semihost')

if host_machine.cpu_family() == 'arm'
    libopencm3_sub = subproject('libopencm3')
    hardware_interface_dep = libopencm3_sub.get_variable('libopencm3_dep')
elif host_machine.cpu_family() == 'riscv32'
    subdir('hardware_interface/esp32c3')
    hardware_interface_dep = esp32c3_hal_dep
endif

libunwind_dep = subproject('libunwind').get_variable('libunwind_dep')

freertos_sub_default_options = 'config_h_dir=.'
freertos_sub = subproject(
    'freertos',
    default_options: [freertos_sub_default_options],
)

freertos_lib = library(
    'freertos',
    dependencies: [
      freertos_sub.get_variable('freertos_dep'),
      picolibc_dep,
    ],
)

build_dir_root = meson.current_build_dir()

subdir('d')

if host_machine.cpu_family() == 'arm'
    path_to_math_lib = '/usr/lib/gcc/arm-none-eabi/8.3.1/thumb/v7-m/nofp/'
    linker_script_name = 'linker_script_arm.ld'
elif host_machine.cpu_family() == 'riscv32'
    path_to_math_lib = '/usr/lib/gcc/riscv64-unknown-elf/12.1.0/rv32imac/ilp32/'
    linker_script_name = 'linker_script_riscv32.ld'
endif

firmware = executable(
    'firmware.elf',
    dependencies: [
        d_dep,
        hardware_interface_dep,
        picolibc_dep,
        libunwind_dep,
    ],
    link_with: [
        semihost_lib,
    ],
    link_language: 'c',
    link_depends: files(linker_script_name),
    link_args: [
        '-static',
        '-L../',
        '-Xlinker', '--script=' + linker_script_name,
        '-L'+path_to_math_lib, '-lgcc',
    ]
)

test(
    'unittests',
    firmware,
)
