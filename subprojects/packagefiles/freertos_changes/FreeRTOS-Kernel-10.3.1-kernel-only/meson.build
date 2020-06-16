includes = include_directories(
  'include',
  get_option('config_h_dir')
)

sources = files(
  'croutine.c',
  'event_groups.c',
  'list.c',
  'queue.c',
  'stream_buffer.c',
  'tasks.c',
  'timers.c',
)

heap_memory_management = files(
  'portable/MemMang/heap_1.c',
)

cc_name = meson.get_compiler('c').get_id()

CPU_specific = files()
CPU_specific_includes = include_directories()

mpu_enabled = get_option('mpu_enabled')

if mpu_enabled
  CPU_specific += files(
      'portable/Common/mpu_wrappers.c'
  )
endif

if cc_name == 'gcc' or cc_name == 'clang'
    if target_machine.cpu_family() == 'arm'
        if target_machine.cpu() == 'cortex-m3'
            if mpu_enabled
                CPU_specific += files('portable/GCC/ARM_CM3_MPU/port.c')
                CPU_specific_includes = include_directories('portable/GCC/ARM_CM3_MPU/')
            else
                CPU_specific += files('portable/GCC/ARM_CM3/port.c')
                CPU_specific_includes = include_directories('portable/GCC/ARM_CM3/')
            endif
        endif
    endif
endif

freertos_dep = declare_dependency(
    include_directories: [includes, CPU_specific_includes],
    sources: [sources, CPU_specific, heap_memory_management],
)
