
set(CMAKE_Swift_COMPILER_ENV_VAR "")

# Local system-specific compiler preferences for this language
include(Platform/${CMAKE_SYSTEM_NAME}-Determine-Swift OPTIONAL)
include(Platform/${CMAKE_SYSTEM_NAME}-Swift OPTIONAL)
if(NOT CMAKE_Swift_COMPILER_NAMES)
  set(CMAKE_Swift_COMPILER_NAMES $ENV{CMAKE_Swift_COMPILER_ENV_VAR} swiftc)
endif()

find_program(CMAKE_Swift_COMPILER NAMES ${CMAKE_Swift_COMPILER_NAMES})

if(NOT CMAKE_Swift_COMPILER_ID_RUN)
  set(CMAKE_Swift_COMPILER_ID_RUN TRUE)

  # Try to identify the compiler.
  set(CMAKE_Swift_COMPILER_ID)
  # TODO(compnerd) identify the compiler vendor

  execute_process(COMMAND
                    ${CMAKE_Swift_COMPILER} "-version"
                  OUTPUT_VARIABLE
                    CMAKE_Swift_COMPILER_VERSION_OUTPUT)
  string(REGEX REPLACE "Swift version ([\\.0-9A-Za-z-]+).*$" "\\1"
         CMAKE_Swift_COMPILER_VERSION "${CMAKE_Swift_COMPILER_VERSION_OUTPUT}")
  message(STATUS "The Swift compiler version is ${CMAKE_Swift_COMPILER_VERSION}")
endif()

# TODO(compnerd) since we are standalone, use a relative path
# ${CMAKE_ROOT}/Modules/CMakeSwiftCompiler.cmake.in
configure_file(${CMAKE_CURRENT_LIST_DIR}/CMakeSwiftCompiler.cmake.in
               ${CMAKE_PLATFORM_INFO_DIR}/CMakeSwiftCompiler.cmake @ONLY)
