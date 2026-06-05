# CMakeHelper

This is the English README. For the Chinese version, please refer to the technical blog article: [用 Android.mk 的写法组织 CMake](https://kgbook.github.io/blog/articles/Android/android-mk-style-cmake-helper)

CMakeHelper is a small CMake module that keeps target declarations consistent across
C++ projects. It uses an Android.mk-style declaration flow: clear local variables,
set `LOCAL_*` values, then include one of the `BUILD_*` files to create the target.
The naming style is familiar to Android.mk users, but the implementation is plain
CMake and can be used for Linux, RISC-V, desktop, embedded, or other platforms.

## Usage

```cmake
include(path/to/cmake/CMakeHelper.cmake)

include(${CLEAR_VARS})
set(LOCAL_MODULE my_headers)
set(LOCAL_EXPORT_C_INCLUDES
    include)
include(${BUILD_INTERFACE_LIBRARY})

include(${CLEAR_VARS})
set(LOCAL_MODULE my_objects)
set(LOCAL_SRC_DIRS
    src/library)
set(LOCAL_INTERFACE_LIBRARIES
    my_headers)
include(${BUILD_OBJECT_LIBRARY})

include(${CLEAR_VARS})
set(LOCAL_MODULE my_app)
set(LOCAL_SRC_FILES
    src/main.cpp)
set(LOCAL_OBJECT_LIBRARIES
    my_objects)
include(${BUILD_EXECUTABLE})
```

Static and object libraries are created with position-independent code enabled.
The module does not force a C++ standard; set that at project level or on specific
targets when your project needs one. The module is cross-platform CMake and is not
tied to Android or any single platform.

For example, this repository enables C++11 from the top-level `CMakeLists.txt`:

```cmake
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
```

## Build Entries

- `CLEAR_VARS`: clears all `LOCAL_*` variables before the next target.
- `BUILD_OBJECT_LIBRARY`: creates an object library.
- `BUILD_STATIC_LIBRARY`: creates a static library.
- `BUILD_SHARED_LIBRARY`: creates a shared library.
- `BUILD_EXECUTABLE`: creates an executable.
- `BUILD_PREBUILT`: creates an imported prebuilt library.
- `BUILD_INTERFACE_LIBRARY`: creates an interface/header-only library.
- `BUILD_HEADER_LIBRARY`: creates an interface/header-only library.
- `ALL_SUBDIR_CMAKELISTS`: adds each direct child directory that contains `CMakeLists.txt`.
- `ALL_CMAKELISTS_UNDER`: recursively adds directories containing `CMakeLists.txt`.

Common arguments:

- `LOCAL_MODULE`: CMake target name.
- `LOCAL_SRC_FILES`: source files for the target.
- `LOCAL_SRC_DIRS`: source directories collected with CMake `aux_source_directory`.
- `LOCAL_C_INCLUDES`: include directories used only by the target.
- `LOCAL_EXPORT_C_INCLUDES`: include directories exported to dependents.
- `LOCAL_STATIC_LIBRARIES`: static-library target dependencies.
- `LOCAL_SHARED_LIBRARIES`: shared-library target dependencies.
- `LOCAL_INTERFACE_LIBRARIES`: interface-library target dependencies.
- `LOCAL_HEADER_LIBRARIES`: interface/header-library target dependencies.
- `LOCAL_OBJECT_LIBRARIES`: object-library targets used by this target.
- `LOCAL_MODULE_FILENAME`: output filename override for static, shared, and executable targets.
- `LOCAL_RUNTIME_OUTPUT_DIRECTORY`: executable output directory override.
- `LOCAL_PREBUILT_MODULE_TYPE`: prebuilt library type, defaulting to `STATIC`.
- `LOCAL_PREBUILT_LOCATION`: imported prebuilt library file path.

`LOCAL_SRC_FILES` and `LOCAL_SRC_DIRS` can be used together. This is useful when
most files live in one module directory, but a few generated or platform-specific
files still need to be listed manually.

`LOCAL_SRC_DIRS` uses CMake `aux_source_directory` internally. It collects only
the current level of each directory, not nested subdirectories. Re-run CMake
configuration after adding new source files to those directories.

Use `ALL_SUBDIR_CMAKELISTS` or `ALL_CMAKELISTS_UNDER` when you want to build
submodules instead of collecting nested sources into one target. Both entries are
included from the parent `CMakeLists.txt`, but they use `add_subdirectory`
internally so each submodule keeps normal CMake directory scope.

```cmake
include(path/to/cmake/CMakeHelper.cmake)

# Add direct children that contain CMakeLists.txt.
include(${ALL_SUBDIR_CMAKELISTS})

# Or add every nested CMakeLists.txt under LOCAL_PATH.
set(LOCAL_PATH ${CMAKE_CURRENT_LIST_DIR}/modules)
include(${ALL_CMAKELISTS_UNDER})
```

`ALL_SUBDIR_CMAKELISTS` is useful for a flat module directory such as
`example/auto_lists/`, where each direct child owns one target group:

```cmake
# example/auto_lists/CMakeLists.txt
include(${ALL_SUBDIR_CMAKELISTS})
```

`ALL_CMAKELISTS_UNDER` is useful when a feature tree has targets more than one
level deep and you still want each target to keep its own `CMakeLists.txt`:

```cmake
# example/auto_lists/recursive/CMakeLists.txt
set(LOCAL_PATH ${CMAKE_CURRENT_LIST_DIR}/modules)
include(${ALL_CMAKELISTS_UNDER})
unset(LOCAL_PATH)
```

The bundled examples separate the main interface styles:

- `example/basic_hello`: uses explicit Android.mk-style target declarations
  (`CLEAR_VARS`, `LOCAL_*`, and `BUILD_EXECUTABLE`).
- `example/auto_lists`: combines both automatic CMakeLists discovery patterns.
  Its top-level `CMakeLists.txt` discovers direct children, and the `recursive`
  child discovers nested modules under `recursive/modules`, including
`modules/core/CMakeLists.txt` and `modules/features/phrase/CMakeLists.txt`.

Prefer `LOCAL_INTERFACE_LIBRARIES` for header-only/interface targets. `LOCAL_HEADER_LIBRARIES`
is kept as a compatibility alias for projects that already use that naming.

## Example

Build and run the bundled hello world example:

```sh
cmake -S . -B build
cmake --build build
./build/example/basic_hello/basic_hello_world
./build/example/auto_lists/recursive/auto_lists_demo
```

Expected output:

```text
Hello, world!
direct child + recursive child via ALL_CMAKELISTS_UNDER
```
