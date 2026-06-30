cmake_minimum_required(VERSION 3.16)

project(CMakeHelper
    VERSION 0.1.0
    LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/CMakeHelper.cmake)

option(BUILD_EXAMPLE "Build examples" ON)
option(BUILD_TESTING "Build tests" ON)

if(BUILD_TESTING)
    enable_testing()
endif()

add_subdirectory(hello)

if(BUILD_EXAMPLE)
    add_subdirectory(example)
endif()
