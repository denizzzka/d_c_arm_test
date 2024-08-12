if(NOT (${IDF_TARGET} STREQUAL "esp32c3"))
     #FIXME:
     message(FATAL_ERROR "Only esp32c3 target is supported")
endif()

if(DEFINED ENV{PRESERVE_I_FILES})
     # Provide fake app_main()
     set(FAKE_APP_MAIN "${CMAKE_SOURCE_DIR}/fake_main.c")
else()
     set(APP_MAIN "call_d_main.c")
endif()

idf_component_register(SRCS
     ${APP_MAIN}
     ${FAKE_APP_MAIN}
     INCLUDE_DIRS "."
     REQUIRES esp_driver_spi freertos
)

set(D_COMPILER "ldc2")
set(D_COMPILER_FLAGS
     $ENV{DFLAGS}
     #-I${CMAKE_CURRENT_SOURCE_DIR} # for import ESP IDF binding
)

if(CMAKE_BUILD_TYPE EQUAL "DEBUG")
    list(APPEND D_COMPILER_FLAGS "-g")
endif()

set(D_OBJ_PATH "${CMAKE_BINARY_DIR}/d_obj.o")

add_custom_command(
     OUTPUT ${D_OBJ_PATH}
     COMMAND ${D_COMPILER} ${D_COMPILER_FLAGS} -c "-of=${D_OBJ_PATH}"
     "${CMAKE_SOURCE_DIR}/main/main.d"
     "${CMAKE_SOURCE_DIR}/main/esp_idf_binding.d"
)

if(NOT DEFINED ENV{PRESERVE_I_FILES})
     add_library(d_obj STATIC ${D_OBJ_PATH})
     set_target_properties(d_obj PROPERTIES LINKER_LANGUAGE C)
     target_link_libraries(${COMPONENT_LIB} d_obj)

     #TODO: remove
     set(DSTDLIBS "/home/denizzz/Dev/dfruntime/install_freertos_riscv32/lib")
     target_link_libraries(${COMPONENT_LIB} ${DSTDLIBS}/libdruntime-ldc-debug.a)
     target_link_libraries(${COMPONENT_LIB} ${DSTDLIBS}/libphobos2-ldc-debug.a)
endif()
