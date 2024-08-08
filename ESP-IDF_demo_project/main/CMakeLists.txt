if(NOT (${IDF_TARGET} STREQUAL "esp32c3"))
     #FIXME:
     message(FATAL_ERROR "Only esp32c3 target is supported")
endif()

if(DEFINED ENV{PRESERVE_I_FILES})
     # Provide fake app_main()
     set(FAKE_APP_MAIN "${CMAKE_SOURCE_DIR}/fake_main.c")
endif()

idf_component_register(SRCS
     "call_d_main.c"
     ${FAKE_APP_MAIN}
     INCLUDE_DIRS "."
     REQUIRES esp_driver_spi freertos
)

set(D_COMPILER "ldc2")
get_filename_component(BINDING_INCLUDE_DIR "$ENV{D_BINDING}" DIRECTORY)
set(D_COMPILER_FLAGS
     "--mtriple=riscv32-unknown-newlib-elf" "--mattr=+m,+c,+a"
     --fthread-model=local-exec
     -I${BINDING_INCLUDE_DIR}
     "-c" "-betterC"
)

set(D_OBJ_PATH "${CMAKE_BINARY_DIR}/d_obj.o")

add_custom_command(
     OUTPUT ${D_OBJ_PATH}
     COMMAND ${D_COMPILER} ${D_COMPILER_FLAGS} "-of=${D_OBJ_PATH}"
     "${CMAKE_SOURCE_DIR}/main/d/main.d"
)

if(NOT DEFINED ENV{PRESERVE_I_FILES})
     add_library(d_obj STATIC ${D_OBJ_PATH})
     set_target_properties(d_obj PROPERTIES LINKER_LANGUAGE C)
     target_link_libraries(${COMPONENT_LIB} d_obj)
endif()
