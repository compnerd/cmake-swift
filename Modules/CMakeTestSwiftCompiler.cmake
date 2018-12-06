
if(CMAKE_Swift_COMPILER_FORCED)
  set(CMAKE_Swift_COMPILER_WORKS TRUE)
  return()
endif()

include(CMakeTestCompilerCommon)

unset(CMAKE_Swift_COMPILER_WORKS CACHE)

if(NOT CMAKE_Swift_COMPILER_WORKS)
  PrintTestCompilerStatus("Swift" "")
  file(WRITE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/main.swift
    "print(\"CMake\")\n")
  try_compile(CMAKE_Swift_COMPILER_WORKS ${CMAKE_BINARY_DIR}
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/main.swift
    OUTPUT_VARIABLE __CMAKE_Swift_COMPILER_OUTPUT)
  set(CMAKE_Swift_COMPILER_WORKS ${CMAKE_Swift_COMPILER_WORKS})
  unset(CMAKE_Swift_COMPILER_WORKS CACHE)
  set(Swift_TEST_WAS_RUN TRUE)
endif()

if(NOT CMAKE_Swift_COMPILER_WORKS)
    PrintTestCompilerStatus("Swift" " -- broken")
else()
  if(Swift_TEST_WAS_RUN)
    PrintTestCompilerStatus("Swift" " -- works")
    file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
      "Determining if the Swift compiler works passed with "
      "the following output:\n${__CMAKE_Swift_COMPILER_OUTPUT}\n\n")
  endif()
endif()

