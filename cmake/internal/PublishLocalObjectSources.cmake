function(publish_local_object_sources LOCAL_TARGET LOCAL_VISIBILITY)
    set(LOCAL_OBJECT_SOURCE_LIBRARIES)

    foreach(LOCAL_DEPENDENCY IN LISTS ARGN)
        if(TARGET ${LOCAL_DEPENDENCY})
            get_target_property(LOCAL_DEPENDENCY_TYPE ${LOCAL_DEPENDENCY} TYPE)
            if(LOCAL_DEPENDENCY_TYPE STREQUAL "OBJECT_LIBRARY")
                list(APPEND LOCAL_OBJECT_SOURCE_LIBRARIES ${LOCAL_DEPENDENCY})
            endif()
        endif()
    endforeach()

    if(LOCAL_OBJECT_SOURCE_LIBRARIES)
        list(REMOVE_DUPLICATES LOCAL_OBJECT_SOURCE_LIBRARIES)
    endif()

    foreach(LOCAL_OBJECT_SOURCE_LIBRARY IN LISTS LOCAL_OBJECT_SOURCE_LIBRARIES)
        target_sources(${LOCAL_TARGET}
            ${LOCAL_VISIBILITY}
                $<TARGET_OBJECTS:${LOCAL_OBJECT_SOURCE_LIBRARY}>)
    endforeach()
endfunction()
