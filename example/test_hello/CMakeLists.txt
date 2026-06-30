if(NOT BUILD_TESTING)
    return()
endif()

include(${CLEAR_VARS})
set(LOCAL_MODULE hello_test)
set(LOCAL_SRC_FILES
    src/test_main.cpp)
set(LOCAL_OBJECT_LIBRARIES
    hello)
# Optional: customize test name (defaults to LOCAL_MODULE)
# set(LOCAL_TEST_NAME hello_unit_test)
# Optional: set working directory for test execution
# set(LOCAL_TEST_WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
# Optional: pass arguments to test
# set(LOCAL_TEST_ARGUMENTS --verbose)
include(${BUILD_TEST})
