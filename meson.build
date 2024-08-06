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
    '-I' + ldc_default_libs_links,
    #'--boundscheck=off', #saves 1.4KB
    #TODO: remove these "--d-version" - used only for Phobos headers compilation:
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

ldc2_conf = get_option('ldc2_conf')
if ldc2_conf != ''
    add_global_arguments('--conf=' + ldc2_conf, language: 'd')
    add_global_link_arguments('--conf=' + ldc2_conf, language: 'd')
endif

picolibc_sub = subproject(
    'picolibc',
    default_options: [
        'multilib=false',
        'newlib-global-errno=true',
        'newlib-initfini-array=false', # .init & .fini processed by libopencm3
        'newlib-io-c99-formats=true',
        'newlib-long-time_t=true',
        'newlib-multithread=true',
        'tinystdio=true',
        'posix-console=true',
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

path_to_math_lib = meson.get_external_property('math_lib')
linker_script = files(meson.get_external_property('linker_script'))
assert(linker_script.length() == 1, 'Only one linker script allowed')

firmware = executable(
    'firmware.elf',
    dependencies: [
        d_dep,
        hardware_interface_dep,
        picolibc_dep,
    ],
    link_with: [
        semihost_lib,
        freertos_lib,
    ],
    link_language: 'c',
    link_depends: linker_script,
    link_args: [
        '-static',
        '-Xlinker', '--script=' + linker_script.get(0).full_path(),
        '-L'+path_to_math_lib[0], '-l'+path_to_math_lib[1],
    ]
)

test(
    'unittests',
    firmware,
)
