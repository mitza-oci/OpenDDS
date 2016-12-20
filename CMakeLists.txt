cmake_minimum_required(VERSION 3.1)
project(OpenDDS CXX)

find_package(TAO REQUIRED CONFIG)

if (NOT OPENDDS_VERSION)
  file(READ "VERSION" VERSION_FILE_CONTENT)
  string(REGEX MATCH "([0-9]\\.)+[0-9]" OPENDDS_VERSION ${VERSION_FILE_CONTENT})
endif()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
option(BUILD_SHARED_LIBS "" ON)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY lib)

include(cmake/AddPackage.cmake)
include(cmake/AddDdsIdlTargets.cmake)
include(cmake/dcps_options.cmake)


add_package(OpenDDS
  VERSION ${OPENDDS_VERSION}
)

set(DDS_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(dds)
add_subdirectory(tools/modeling/codegen/model)
add_subdirectory(examples/DCPS)
add_subdirectory(tests)
add_subdirectory(performance-tests)
add_subdirectory(DevGuideExamples)


install_package(OpenDDS
  CONFIG_OPTIONS ${DDS_OPTIONS}
  PREREQUISITE TAO
  EXTRA_CMAKE_FILES cmake/AddDdsIdlTargets.cmake
)


## This line must be the last of the file, so we can run the post install script
## in the correct order
add_subdirectory(cmake)