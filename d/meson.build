add_languages('d', native:false)

dpp = subproject('dpp').get_variable('dpp_preprocessor')

root_dir = meson.source_root()
subprojects_dir = root_dir + '/subprojects/'

libstd_include_path = subprojects_dir / 'picolibc' / 'newlib' / 'libc' / 'include'
picolibc_h_include_path = build_dir_root / 'subprojects' / 'picolibc'

freertos_binding = dpp.process(
    files(
        'freertos_dpp_bindings/freertos.dpp',
    ),
    extra_args: [
        '--include-path=' + libstd_include_path,
        '--include-path=' + picolibc_h_include_path,
        '--include-path=' + subprojects_dir / 'freertos' / 'include',
        '--include-path=' + subprojects_dir / 'freertos' / 'portable/GCC/ARM_CM3', #TODO: get this from freertos_dep?
        '--include-path=' + root_dir, #for FreeRTOSConfig.h
    ]
)

#FIXME: _unused custom target temporary added, https://github.com/mesonbuild/meson/issues/6695#issuecomment-729734736
cp = find_program('cp')
freertos_d_unused = custom_target(
    'Temporary FreeRTOS bindings generator',
    input: freertos_binding,
    output: 'freertos.d',
    command : [cp, '@INPUT@', '@OUTPUT@'],
    build_by_default: true,
)

phobos_includes = subproject('phobos').get_variable('include_directories')

freertos_d_dep = declare_dependency(
    sources: [
        freertos_binding,
    ],
    include_directories: [
        include_directories( #FIXME: remove this, https://github.com/mesonbuild/meson/issues/6695#issuecomment-729734736
            'freertos_dpp_bindings',
            'druntime_freertos_backend',
        ),
        phobos_includes,
    ],
)

subdir('druntime_freertos_backend')

druntime_sub = subproject(
    'druntime',
    default_options: [
        'use_external_backend=true',
    ]
)

druntime_dep = druntime_sub.get_variable('druntime_dep')

druntime_lib = library(
    'druntime',
    sources: [
        freertos_druntime_backend,
    ],
    include_directories: include_directories(
        'druntime_freertos_backend',
    ),
    dependencies: [
        druntime_dep,
        freertos_d_dep,
        picolibc_dep,
    ],
    d_debug: [
        #'SENTINEL',
        #'MEMSTOMP',
        #'PTRCHECK',
        #'PTRCHECK2',
    ],
)

d_dep_sources = [
    'source/app.d',
    'source/arm_cortex_debug.d',
    'source/drivers/max7219.d',
]

if host_machine.cpu_family() == 'arm'
    libopencm3_binding = dpp.process(
        files(
            'source/bindings/libopencm3.dpp',
        ),
        extra_args: [
            '--include-path=' + libstd_include_path,
            '--include-path=' + picolibc_h_include_path,
            '--include-path=' + subprojects_dir / 'libopencm3/include/',
            #'--define=STM32F1',
            '--define=STM32F4',
        ]
    )

    d_dep_sources += libopencm3_binding
endif

d_dep = declare_dependency(
    sources: d_dep_sources,
    include_directories: [
        'source',
        'source/bindings',
    ],
    dependencies: [
        #FIXME: duplicates link_with content because dependencies also contains includes with correct d-versions
        druntime_dep,
        freertos_d_dep,
    ],
    link_with: [
        druntime_lib,
        freertos_lib,
    ]
)
