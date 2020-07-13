project('libopencm3', 'c')

# for ensure what appropriate compiler is installed
__gcc_for_libopencm3_unused = find_program('arm-none-eabi-gcc')

legacy_make = find_program('make')

lib_filename = 'libopencm3_stm32f1.a'

make_all = custom_target(
    'Run makefile',
    command : [legacy_make, '-C', meson.current_source_dir(), 'lib/stm32/f1'],
    output: 'Makefile' #Any file
)

cp = find_program('cp')

_lib = custom_target('Copy library',
    depends: make_all,
    command : [cp, meson.current_source_dir()+'/lib/'+lib_filename, '@OUTDIR@'],
    output: lib_filename
)

includes = include_directories('./include/')

reset_handler_dep = library(
    'reset_handler',
    'lib/cm3/vector.c', #reset_handler is here
    include_directories: includes,
)

ld_script_gen = generator(
    legacy_make,
    arguments : [
        '-f', '@CURRENT_SOURCE_DIR@/mk/gen-ldscript.mk',
        'generate',
        'RENAME_TO=@OUTPUT@',
        'OPENCM3_DIR=@CURRENT_SOURCE_DIR@',
        '@EXTRA_ARGS@',
    ],
    output: '@BASENAME@.ld',
)

libopencm3_dep = declare_dependency(
    include_directories: includes,
    link_with: [_lib, reset_handler_dep],
)
