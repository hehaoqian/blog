---
layout: post
title: CMake debug tips
categories: [profiler]
description:
keywords:
---

Tips of debugging CMake

## Version

Currently I am using CMake 3.20, the version which current LLVM requires

## Printing

```cmake
message(DEBUG "Hello World")
```

Then enable debug log level to print it

```sh
cmake --log-level=DEBUG
```

### Print log with context

```sh
cmake --log-level=DEBUG --log-context
```

This should be used with `CMAKE_MESSAGE_CONTEXT` in cmake files

```cmake
set(CMAKE_MESSAGE_CONTEXT top)
message(STATUS "hello world")
```

Example output

```text
-- [top] hello world
```

## Tracing

```sh
# Trace cmake executable, print the command executed as it runs
cmake --trace
```

Example outputs

```text
Put cmake in trace mode.
/var/home/main/src/test_cmake/CMakeLists.txt(1):  cmake_minimum_required(VERSION 3.20.0 )
/var/home/main/src/test_cmake/CMakeLists.txt(3):  project(ProjectName )
```

### With variable expanded

```sh
cmake --trace-expand
```

Example outputs

```text
var/home/main/src/test_cmake/CMakeLists.txt(1):  cmake_minimum_required(VERSION 3.20.0 )Put cmake in trace mode.
Put cmake in trace mode, but with variables expanded.

/var/home/main/src/test_cmake/CMakeLists.txt(3):  project(ProjectName )
/usr/share/cmake/Modules/CMakeDetermineSystem.cmake(35):  if(CMAKE_HOST_UNIX )
/usr/share/cmake/Modules/CMakeDetermineSystem.cmake(36):  find_program(CMAKE_UNAME NAMES uname PATHS /bin /usr/bin /usr/local/bin )
/usr/share/cmake/Modules/CMakeDetermineSystem.cmake(37):  if(CMAKE_UNAME )
/usr/share/cmake/Modules/CMakeDetermineSystem.cmake(38):  if(CMAKE_HOST_SYSTEM_NAME STREQUAL AIX )
/usr/share/cmake/Modules/CMakeDetermineSystem.cmake(50):  else()
/usr/share/cmake/Modules/CMakeDetermineSystem.cmake(51):  execute_process(COMMAND /usr/bin/uname -r OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET )
/usr/share/cmake/Modules/CMakeDetermineSystem.cmake(56):  if(CMAKE_HOST_SYSTEM_NAME MATCHES Linux|CYGWIN.*|MSYS.*|^GNU$|Android )
```

### Filter tracing output

Sometimes, output is too messy, better to filter by files

```sh
cmake --trace-source=<file>

# This can be listed multiple times

cmake --trace-source=<file1> --trace-source=<file2>
```

Example outputs

```text
Put cmake in trace mode.
Put cmake in trace mode, but with variables expanded.
Put cmake in trace mode, but output only lines of a specified file. Multiple options are allowed.
/var/home/main/src/test_cmake/CMakeLists.txt(1):  cmake_minimum_required(VERSION 3.20.0 )
/var/home/main/src/test_cmake/CMakeLists.txt(3):  project(ProjectName )
/var/home/main/src/test_cmake/CMakeLists.txt(4):  add_executable(hello hello.c )
```

## Debug mode

```sh
# Enable output
cmake --debug-output
```

Example outputs

```text
Running with debug output on.
-- Configuring done (0.0s)
-- Generating /var/home/main/src/test_cmake
   Called from: [1]     /var/home/main/src/test_cmake/CMakeLists.txt
-- Generating done (0.0s)
-- Build files have been written to: /var/home/main/src/test_cmake
```

## Dump system information and cache variables

```sh
# The current working directory should be inside binary dir of CMake
cmake --system-information <OUTPUT_FILE>
```

## Compilation database

```sh
cmake . -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

This will generate `compile_commands.json` inside CMake binary dir,
which shows how each object files are compiled.

Example outputs:

```text
[
{
  "directory": "/var/home/main/src/test_cmake",
  "command": "/usr/bin/cc -o CMakeFiles/hello.dir/hello.c.o -c /var/home/main/src/test_cmake/hello.c",
  "file": "/var/home/main/src/test_cmake/hello.c",
  "output": "CMakeFiles/hello.dir/hello.c.o"
}
]
```

## Property Origin Debugging

<https://cmake.org/cmake/help/v3.20/manual/cmake-buildsystem.7.html#property-origin-debugging>

Because build specifications can be determined by dependencies, the lack of locality of code which creates a target and code which is responsible for setting build specifications may make the code more difficult to reason about. cmake(1) provides a debugging facility to print the origin of the contents of properties which may be determined by dependencies. The properties which can be debugged are listed in the CMAKE_DEBUG_TARGET_PROPERTIES variable documentation:

```cmake
set(CMAKE_DEBUG_TARGET_PROPERTIES
  INCLUDE_DIRECTORIES
  COMPILE_DEFINITIONS
  POSITION_INDEPENDENT_CODE
  CONTAINER_SIZE_REQUIRED
  LIB_VERSION
)
```

add_executable(exe1 exe1.cpp)
In the case of properties listed in COMPATIBLE_INTERFACE_BOOL or COMPATIBLE_INTERFACE_STRING, the debug output shows which target was responsible for setting the property, and which other dependencies also defined the property. In the case of COMPATIBLE_INTERFACE_NUMBER_MAX and COMPATIBLE_INTERFACE_NUMBER_MIN, the debug output shows the value of the property from each dependency, and whether the value determines the new extreme.

Example usage in CMake files:

```cmake
set(CMAKE_DEBUG_TARGET_PROPERTIES
        COMPILE_OPTIONS
)
add_executable(hello hello.c)
set_target_properties(hello PROPERTIES COMPILE_OPTIONS -DA=1)
```

Example outputs:

```text
-- Configuring done (0.0s)
CMake Debug Log at CMakeLists.txt:11 (set_target_properties):
  Used compile options for target hello:

   * -DA=1
```

## Debug by ninja generator

The default generator on Linux is `make`
Ninja build is a more modern build system

```sh
# Enable ninja generator
cmake -G Ninja
```

### Trace Ninja

```sh
# explain      explain what caused a command to execute
# `-d` can be specified multiple times
cmake --build . -- -d explain
```

Example outputs

```text
ninja explain: output CMakeFiles/hello.dir/hello.c.o older than most recent input /var/home/main/src/test_cmake/hello.c (1701484671633219463 vs 1701484682115473402)
ninja explain: CMakeFiles/hello.dir/hello.c.o is dirty
ninja explain: hello is dirty
[2/2] Linking C executable hello
```

Other debug commands provided by `ninja`

```text
debugging modes:
  stats        print operation counts/timing info
  explain      explain what caused a command to execute
  keepdepfile  don't delete depfiles after they're read by ninja
  keeprsp      don't delete @response files on success
```

### View dependency inside browser

```sh
cmake --build . -- -t browse
```


