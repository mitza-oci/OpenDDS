cmake_minimum_required(VERSION 3.3)
project(OpenDDS CXX)

include(cmake/find_or_download_tao.cmake)

if (NOT OPENDDS_VERSION)
  file(READ "VERSION" VERSION_FILE_CONTENT)
  string(REGEX MATCH "([0-9]\\.)+[0-9]" OPENDDS_VERSION ${VERSION_FILE_CONTENT})
endif()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
option(BUILD_SHARED_LIBS "" ON)

set(DDS_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

include(cmake/opendds_options.cmake)
include(cmake/opendds_aspects.cmake)
include(cmake/dds_idl_sources.cmake)


ace_add_package(OpenDDS
  VERSION ${OPENDDS_VERSION}
)

enable_testing()

add_subdirectory(dds)
add_subdirectory(tools)
add_subdirectory(examples/DCPS)
add_subdirectory(tests)
add_subdirectory(performance-tests)
add_subdirectory(DevGuideExamples)
add_subdirectory(bin/PerlDDS)

ace_install_package(OpenDDS
  CONFIG_OPTIONS ${DDS_OPTIONS}
  PREREQUISITE TAO
  EXTRA_CMAKE_FILES cmake/dds_idl_sources.cmake
                    cmake/opendds_aspects.cmake
)


## This line must be the last of the file, so we can run the post install script
## in the correct order
add_subdirectory(cmake)