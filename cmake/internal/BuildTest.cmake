if(NOT LOCAL_MODULE)
    message(FATAL_ERROR "LOCAL_MODULE must be set before including BUILD_TEST")
endif()

include(${LOCAL_BUILD_SYSTEM_PATH}/internal/CollectLocalSources.cmake)
include(${LOCAL_BUILD_SYSTEM_PATH}/internal/PublishLocalObjectSources.cmake)

add_executable(${LOCAL_MODULE} ${LOCAL_SRC_FILES})

foreach(LOCAL_OBJECT_LIBRARY IN LISTS LOCAL_OBJECT_LIBRARIES)
    target_link_libraries(${LOCAL_MODULE}
        PRIVATE
            ${LOCAL_OBJECT_LIBRARY})
endforeach()

if(LOCAL_EXPORT_C_INCLUDES OR LOCAL_C_INCLUDES)
    target_include_directories(${LOCAL_MODULE}
        PUBLIC
            ${LOCAL_EXPORT_C_INCLUDES}
        PRIVATE
            ${LOCAL_C_INCLUDES})
endif()

set(LOCAL_DEPENDENCIES
        ${LOCAL_STATIC_LIBRARIES}
        ${LOCAL_SHARED_LIBRARIES}
        ${LOCAL_INTERFACE_LIBRARIES}
        ${LOCAL_OBJECT_LIBRARIES}
        ${LOCAL_HEADER_LIBRARIES})

if(LOCAL_DEPENDENCIES)
    target_link_libraries(${LOCAL_MODULE}
        PRIVATE
            ${LOCAL_DEPENDENCIES})
    publish_local_object_sources(${LOCAL_MODULE} PRIVATE ${LOCAL_DEPENDENCIES})
endif()

if(LOCAL_MODULE_FILENAME)
    set_target_properties(${LOCAL_MODULE} PROPERTIES
        OUTPUT_NAME ${LOCAL_MODULE_FILENAME})
endif()

if(LOCAL_RUNTIME_OUTPUT_DIRECTORY)
    set_target_properties(${LOCAL_MODULE} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${LOCAL_RUNTIME_OUTPUT_DIRECTORY})
endif()

# Register with CTest
if(LOCAL_TEST_NAME)
    set(LOCAL_TEST_TARGET ${LOCAL_TEST_NAME})
else()
    set(LOCAL_TEST_TARGET ${LOCAL_MODULE})
endif()

if(LOCAL_TEST_WORKING_DIRECTORY)
    add_test(NAME ${LOCAL_TEST_TARGET}
             COMMAND ${LOCAL_MODULE} ${LOCAL_TEST_ARGUMENTS}
             WORKING_DIRECTORY ${LOCAL_TEST_WORKING_DIRECTORY})
else()
    add_test(NAME ${LOCAL_TEST_TARGET}
             COMMAND ${LOCAL_MODULE} ${LOCAL_TEST_ARGUMENTS})
endif()

unset(LOCAL_DEPENDENCIES)
unset(LOCAL_TEST_TARGET)
