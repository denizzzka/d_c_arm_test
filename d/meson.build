add_languages('d', native:false)

dpp = subproject('dpp').get_variable('dpp_preprocessor')

root_dir = meson.source_root()
subprojects_dir = root_dir + '/subprojects/'

libopencm3_binding = dpp.process(
    files(
        'source/bindings/gpio.dpp',
    ),
    extra_args: [
        '--include-path=' + subprojects_dir + 'libopencm3/include/',
        '--define=STM32F1'
    ]
)

#FIXME: https://github.com/mesonbuild/meson/issues/7330
freertos_subdir = 'FreeRTOS-Kernel-10.3.1-kernel-only'

freertos_binding = dpp.process(
    files(
        'freertos_dpp_bindings/freertos.dpp',
    ),
    extra_args: [
        '--include-path=' + subprojects_dir + 'freertos/' + freertos_subdir + '/include/',
        '--include-path=' + subprojects_dir + 'freertos/' + freertos_subdir + '/portable/GCC/ARM_CM3/', #TODO: get this from freertos_dep?
        '--include-path=' + root_dir, #for FreeRTOSConfig.h
    ]
)

freertos_d_dep = declare_dependency(
    sources: [
        #freertos_binding,
        'freertos_dpp_bindings/freertos.d', #TODO: remove this file, https://github.com/mesonbuild/meson/issues/7140
    ],
    include_directories: include_directories(
        'freertos_dpp_bindings',
        'freertos_druntime_backend',
    )
)

freertos_druntime_backend = [
    'freertos_druntime_backend/external/core/abort.d',
    'freertos_druntime_backend/external/core/condition.d',
    'freertos_druntime_backend/external/core/event.d',
    'freertos_druntime_backend/external/core/fiber.d',
    'freertos_druntime_backend/external/core/memory.d',
    'freertos_druntime_backend/external/core/mutex.d',
    'freertos_druntime_backend/external/core/semaphore.d',
    'freertos_druntime_backend/external/core/thread.d',
    'freertos_druntime_backend/external/core/time.d',
    'freertos_druntime_backend/external/core/types.d',
    'freertos_druntime_backend/external/libc/errno.d',
    'freertos_druntime_backend/external/libc/stdio_.d',
    'freertos_druntime_backend/external/libc/wchar_.d',
    'freertos_druntime_backend/external/rt/config.d',
    'freertos_druntime_backend/external/rt/dmain.d',
    'freertos_druntime_backend/external/rt/monitor_.d',
    'freertos_druntime_backend/external/rt/sections.d',
]


druntime_dep = subproject(
    'druntime',
).get_variable('druntime_dep')

druntime_lib = library(
    'druntime',
    sources: [
        freertos_druntime_backend,
    ],
    include_directories: include_directories(
        './freertos_druntime_backend/',
    ),
    dependencies: [
        druntime_dep,
        freertos_d_dep,
        picolibc_dep,
    ],
    d_module_versions: [
        'DruntimeAbstractRt',
        'CRuntime_Abstract',
        'ExternStackShell',
        'AsmExternal', #used by fiber module
        'CoreUnittest',
        'ThreadsDisabled',
        'OnlyLowMemUnittest', #disables memory-greedy unittests
        'SupportSanitizers', #FIXME: remove, for debugging purposes only
    ],
    d_debug: [
        'SENTINEL',
    ]
)

d_dep = declare_dependency(
    sources: [
        'source/app.d',
        'source/arm_cortex_debug.d',
        libopencm3_binding,
    ],
    include_directories: [
        'source',
        'source/bindings',
    ],
    dependencies: [
        freertos_d_dep,
        #druntime_dep, #TODO: redundant
    ],
    link_with: [
        druntime_lib,
        freertos_lib,
    ]
)
