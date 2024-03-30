add_languages('d', native:false)

dpp = subproject('dpp').get_variable('dpp_preprocessor')

root_dir = meson.source_root()
subprojects_dir = root_dir + '/subprojects/'

libstd_include_path = subprojects_dir / 'picolibc' / 'newlib' / 'libc' / 'include'
picolibc_h_include_path = build_dir_root / 'subprojects' / 'picolibc'

phobos_includes = subproject('phobos').get_variable('include_directories')

freertos_d_backend_dep = declare_dependency(
    include_directories: [
        include_directories('druntime_freertos_backend', 'freertos_dpp_bindings'),
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
        freertos_d_backend_dep,
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
        freertos_d_backend_dep,
    ],
    link_with: [
        druntime_lib,
        freertos_lib,
    ]
)
