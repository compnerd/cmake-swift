
if(UNIX)
  set(CMAKE_Swift_OUTPUT_EXTENSION .o)
else()
  set(CMAKE_Swift_OUTPUT_EXTENSION .obj)
endif()

if(CMAKE_Swift_COMPILER_ID)
  include(Compiler/${CMAKE_Swift_COMPILER_ID}-Swift OPTIONAL)
  if(CMAKE_SYSTEM_PROCESSOR)
    include(Platform/${CMAKE_EFFECTIVE_SYSTEM_NAME}-${CMAKE_Swift_COMPILER_ID}-Swift-${CMAKE_SYSTEM_PROCESSOR} OPTIONAL)
  endif()
  include(Platform/${CMAKE_EFFECTIVE_SYSTEM_NAME}-${CMAKE_Swift_COMPILER_ID}-Swift OPTIONAL)
endif()

set(CMAKE_INCLUDE_FLAG_Swift -I)
set(CMAKE_Swift_COMPILE_OPTIONS_TARGET "-target ")
set(CMAKE_Swift_COMPILER_ARG1 -frontend)

if(NOT CMAKE_DEPFILE_FLAGS_Swift)
  set(CMAKE_DEPFILE_FLAGS_Swift "-emit-dependencies -emit-dependencies-path <DEPFILE> -emit-reference-dependencies-path <OBJECT>.swiftdeps")
endif()

if(NOT CMAKE_Swift_COMPILE_OBJECT)
  set(CMAKE_Swift_COMPILE_OBJECT "<CMAKE_Swift_COMPILER> <FLAGS> -module-name <SWIFT_MODULE_NAME> -c -primary-file <SOURCE> <SWIFT_AUXILIARY_SOURCES> -o <OBJECT> -emit-module-path <OBJECT>.swiftmodule -emit-module-doc-path <OBJECT>.swiftdoc")
endif()

if(NOT CMAKE_Swift_CREATE_SHARED_LIBRARY)
  if(CMAKE_Swift_COMPILER_TARGET)
    set(CMAKE_Swift_CREATE_SHARED_LIBRARY "${CMAKE_Swift_COMPILER} -emit-library -target <CMAKE_Swift_COMPILER_TARGET> <LINK_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
  else()
    set(CMAKE_Swift_CREATE_SHARED_LIBRARY "${CMAKE_Swift_COMPILER} -emit-library <LINK_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
  endif()
endif()

if(NOT CMAKE_Swift_CREATE_SHARED_MODULE)
  set(CMAKE_Swift_CREATE_SHARED_MODULE ${CMAKE_Swift_CREATE_SHARED_LIBRARY})
endif()

if(NOT CMAKE_Swift_LINK_EXECUTABLE)
  set(CMAKE_Swift_LINK_EXECUTABLE "<CMAKE_Swift_COMPILER> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
endif()

if(NOT CMAKE_Swift_CREATE_STATIC_LIBRARY)
  set(CMAKE_Swift_ARCHIVE_CREATE "<CMAKE_AR> crs <TARGET> <OBJECTS>")
  set(CMAKE_Swift_ARCHIVE_FINISH "")
endif()

set(CMAKE_Swift_INFORMATION_LOADED TRUE)

