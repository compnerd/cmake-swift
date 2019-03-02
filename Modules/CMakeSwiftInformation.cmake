
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

set(CMAKE_Swift_FLAGS_DEBUG_INIT "-g")
set(CMAKE_Swift_FLAGS_RELEASE_INIT "-O")
set(CMAKE_Swift_FLAGS_RELWITHDEBINFO_INIT "-O -g")
set(CMAKE_Swift_FLAGS_MINSIZEREL_INIT "-Osize")

if(NOT CMAKE_DEPFILE_FLAGS_Swift)
  set(CMAKE_DEPFILE_FLAGS_Swift "-emit-dependencies -emit-dependencies-path <DEPFILE> -emit-reference-dependencies-path <OBJECT>.swiftdeps")
endif()

if(NOT CMAKE_Swift_COMPILE_OBJECT)
  set(CMAKE_Swift_COMPILE_OBJECT "<CMAKE_Swift_COMPILER> <FLAGS> -module-name <SWIFT_MODULE_NAME> -module-link-name <SWIFT_LIBRARY_NAME> -c -primary-file <SOURCE> <SWIFT_AUXILIARY_SOURCES> -o <OBJECT> -emit-module-path <SWIFT_PARTIAL_MODULE> -emit-module-doc-path <SWIFT_PARTIAL_DOC>")
endif()

if(NOT CMAKE_Swift_CREATE_SHARED_LIBRARY)
  if(CMAKE_Swift_COMPILER_TARGET)
    set(CMAKE_Swift_CREATE_SHARED_LIBRARY "${CMAKE_Swift_COMPILER} -emit-library -target <CMAKE_Swift_COMPILER_TARGET> <LINK_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
  else()
    set(CMAKE_Swift_CREATE_SHARED_LIBRARY "${CMAKE_Swift_COMPILER} -emit-library <LINK_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
  endif()
  set(CMAKE_Swift_CREATE_SHARED_LIBRARY "${CMAKE_Swift_CREATE_SHARED_LIBRARY};${CMAKE_Swift_COMPILER} -frontend <FLAGS> -sil-merge-partial-modules <SWIFT_PARTIAL_MODULES> -emit-module -o <TARGET_SWIFT_MODULE> -emit-module-doc-path <TARGET_SWIFT_DOC>")
endif()

if(NOT CMAKE_Swift_CREATE_SHARED_MODULE)
  set(CMAKE_Swift_CREATE_SHARED_MODULE ${CMAKE_Swift_CREATE_SHARED_LIBRARY})
endif()

if(NOT CMAKE_Swift_LINK_EXECUTABLE)
  set(CMAKE_Swift_LINK_EXECUTABLE "${CMAKE_Swift_COMPILER} -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
endif()

if(NOT CMAKE_Swift_CREATE_STATIC_LIBRARY)
  set(CMAKE_Swift_ARCHIVE_CREATE "<CMAKE_AR> crs <TARGET> <OBJECTS>")
  set(CMAKE_Swift_ARCHIVE_FINISH "")
endif()

set(CMAKE_Swift_INFORMATION_LOADED TRUE)

