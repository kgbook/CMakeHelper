if(NOT LOCAL_MODULE)
    message(FATAL_ERROR "LOCAL_MODULE must be set before including BUILD_INTERFACE_LIBRARY")
endif()

add_library(${LOCAL_MODULE} INTERFACE)

if(LOCAL_EXPORT_C_INCLUDES)
    target_include_directories(${LOCAL_MODULE}
        INTERFACE
            ${LOCAL_EXPORT_C_INCLUDES})
endif()

set(LOCAL_DEPENDENCIES
    ${LOCAL_STATIC_LIBRARIES}
    ${LOCAL_SHARED_LIBRARIES}
    ${LOCAL_INTERFACE_LIBRARIES}
    ${LOCAL_HEADER_LIBRARIES})

if(LOCAL_DEPENDENCIES)
    target_link_libraries(${LOCAL_MODULE}
        INTERFACE
            ${LOCAL_DEPENDENCIES})
endif()

foreach(LOCAL_OBJECT_LIBRARY IN LISTS LOCAL_OBJECT_LIBRARIES)
    target_link_libraries(${LOCAL_MODULE}
        INTERFACE
            ${LOCAL_OBJECT_LIBRARY})
    target_sources(${LOCAL_MODULE}
        INTERFACE
            $<TARGET_OBJECTS:${LOCAL_OBJECT_LIBRARY}>)
endforeach()

unset(LOCAL_DEPENDENCIES)
