set(LOCAL_PATH ${CMAKE_CURRENT_LIST_DIR}/modules)
include(${ALL_CMAKELISTS_UNDER})
unset(LOCAL_PATH)

include(${CLEAR_VARS})
set(LOCAL_MODULE auto_lists_demo)
set(LOCAL_SRC_FILES
    src/main.cpp)
set(LOCAL_STATIC_LIBRARIES
    auto_lists_direct
    auto_lists_phrase)
include(${BUILD_EXECUTABLE})
