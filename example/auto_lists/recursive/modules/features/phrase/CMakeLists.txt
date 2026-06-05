include(${CLEAR_VARS})
set(LOCAL_MODULE auto_lists_phrase)
set(LOCAL_SRC_FILES
    src/phrase.cpp)
set(LOCAL_EXPORT_C_INCLUDES
    ${CMAKE_CURRENT_LIST_DIR}/include)
set(LOCAL_STATIC_LIBRARIES
    auto_lists_core)
include(${BUILD_STATIC_LIBRARY})
