include_guard(GLOBAL)

get_filename_component(LOCAL_BUILD_SYSTEM_PATH "${CMAKE_CURRENT_LIST_FILE}" DIRECTORY)

set(CLEAR_VARS "${LOCAL_BUILD_SYSTEM_PATH}/internal/ClearVars.cmake")
set(BUILD_OBJECT_LIBRARY "${LOCAL_BUILD_SYSTEM_PATH}/internal/BuildObjectLibrary.cmake")
set(BUILD_STATIC_LIBRARY "${LOCAL_BUILD_SYSTEM_PATH}/internal/BuildStaticLibrary.cmake")
set(BUILD_SHARED_LIBRARY "${LOCAL_BUILD_SYSTEM_PATH}/internal/BuildSharedLibrary.cmake")
set(BUILD_EXECUTABLE "${LOCAL_BUILD_SYSTEM_PATH}/internal/BuildExecutable.cmake")
set(BUILD_PREBUILT "${LOCAL_BUILD_SYSTEM_PATH}/internal/BuildPrebuilt.cmake")
set(BUILD_INTERFACE_LIBRARY "${LOCAL_BUILD_SYSTEM_PATH}/internal/BuildInterfaceLibrary.cmake")
set(BUILD_HEADER_LIBRARY "${LOCAL_BUILD_SYSTEM_PATH}/internal/BuildHeaderLibrary.cmake")
set(ALL_SUBDIR_CMAKELISTS "${LOCAL_BUILD_SYSTEM_PATH}/internal/AllSubdirCMakeLists.cmake")
set(ALL_CMAKELISTS_UNDER "${LOCAL_BUILD_SYSTEM_PATH}/internal/AllCMakeListsUnder.cmake")
