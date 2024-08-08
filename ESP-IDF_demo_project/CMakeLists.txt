# For more information about build system see
# https://docs.espressif.com/projects/esp-idf/en/latest/api-guides/build-system.html
# The following five lines of boilerplate have to be in your project's
# CMakeLists in this exact order for cmake to work correctly
cmake_minimum_required(VERSION 3.16)

if(DEFINED ENV{PRESERVE_I_FILES})
     # Preserve *.i files
     set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -save-temps")
endif()

include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(mcu_software)
