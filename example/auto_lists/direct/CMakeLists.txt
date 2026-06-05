include(${CLEAR_VARS})
set(LOCAL_MODULE auto_lists_direct)
set(LOCAL_SRC_FILES
    src/direct.cpp)
set(LOCAL_EXPORT_C_INCLUDES
    ${CMAKE_CURRENT_LIST_DIR}/include)
include(${BUILD_STATIC_LIBRARY})
