# AGENTS.md

## Structure

- `cmake/` — the deliverable CMake module. Include `cmake/CMakeHelper.cmake` from any project.
- `hello/` — object library example (header-only + object files).
- `example/` — executable linking against `hello`.

## CMake Module Usage

Android.mk-style declaration flow: clear local variables, set `LOCAL_*` values, then `include(${BUILD_*})`.

```cmake
include(path/to/cmake/CMakeHelper.cmake)

include(${CLEAR_VARS})
set(LOCAL_MODULE my_target)
set(LOCAL_SRC_FILES src/foo.cpp)
include(${BUILD_EXECUTABLE})  # or BUILD_STATIC_LIBRARY, BUILD_SHARED_LIBRARY, etc.
```

Available targets: `BUILD_OBJECT_LIBRARY`, `BUILD_STATIC_LIBRARY`, `BUILD_SHARED_LIBRARY`, `BUILD_EXECUTABLE`, `BUILD_TEST`, `BUILD_PREBUILT`, `BUILD_EXTERNAL_PROJECT`, `BUILD_INTERFACE_LIBRARY`, `BUILD_HEADER_LIBRARY`,
`ALL_SUBDIR_CMAKELISTS`, `ALL_CMAKELISTS_UNDER`.

Subdirectory helpers:

- `CLEAR_VARS` — include before each module declaration; it clears all `LOCAL_*` variables so targets do not leak settings into each other.
- `ALL_SUBDIR_CMAKELISTS` — include child directories that directly contain `CMakeLists.txt`, one level under the current `CMakeLists.txt` directory.
- `ALL_CMAKELISTS_UNDER` — include every nested `CMakeLists.txt` below the current directory, or below `LOCAL_PATH` when it is set.

## Code Style

- **Pattern**: Android.mk-style — `include(${CLEAR_VARS})` → set `LOCAL_*` vars → `include(${BUILD_*})`
- **Naming**: All `LOCAL_*` variables are cleared by `${CLEAR_VARS}` before each target
- **Target names**: Use `hello` not `libhello` — the module handles lib prefix internally
- **C++ standard**: Consumer projects set their own. Root `CMakeLists.txt` uses C++11 minimum for embedded/RTOS compatibility.
- **PIC**: Static and object libraries are built with `-fPIC`

## Quirks

- `LOCAL_SRC_DIRS` uses CMake's `aux_source_directory` internally — collects only one directory level, not recursive. Re-run CMake configuration after adding new files.
- `LOCAL_SRC_FILES` and `LOCAL_SRC_DIRS` can be used together.
- `LOCAL_OBJECT_LIBRARIES` may name an object target declared later. Its
  `$<TARGET_OBJECTS:...>` expression is propagated through the target's
  interface and resolved at generation time. Do not use it for ordinary
  library dependencies.

## Test Targets

`BUILD_TEST` creates an executable and registers it with CTest. Enable testing in your root `CMakeLists.txt` with `enable_testing()` before using this target.

```cmake
include(${CLEAR_VARS})
set(LOCAL_MODULE my_test)
set(LOCAL_SRC_FILES tests/test_foo.cpp)
set(LOCAL_OBJECT_LIBRARIES my_lib)
# Optional: customize test name (defaults to LOCAL_MODULE)
set(LOCAL_TEST_NAME my_unit_test)
# Optional: set working directory for test execution
set(LOCAL_TEST_WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
# Optional: pass arguments to test executable
set(LOCAL_TEST_ARGUMENTS --verbose --filter=*)
include(${BUILD_TEST})
```

Test-specific variables:

- `LOCAL_TEST_NAME` — CTest test name. Defaults to `LOCAL_MODULE` when unset.
- `LOCAL_TEST_WORKING_DIRECTORY` — working directory when the test runs.
- `LOCAL_TEST_ARGUMENTS` — command-line arguments passed to the test executable.

Run tests with `ctest` or `cmake --build . --target test` after configuring with `-DBUILD_TESTING=ON`.
