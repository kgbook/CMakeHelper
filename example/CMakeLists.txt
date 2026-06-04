include(${CLEAR_VARS})
set(LOCAL_MODULE hello_world)
set(LOCAL_SRC_FILES
    src/main.cpp)
set(LOCAL_OBJECT_LIBRARIES
    hello)
include(${BUILD_EXECUTABLE})
