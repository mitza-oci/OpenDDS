cmake_minimum_required(VERSION 3.6)
project(OpenDDS CXX)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
option(BUILD_SHARED_LIBS "" ON)
set(CMAKE_LINK_DEPENDS_NO_SHARED ON)


include(cmake/find_or_download_tao.cmake)

if (NOT OPENDDS_VERSION)
  file(READ "VERSION" VERSION_FILE_CONTENT)
  string(REGEX MATCH "([0-9]\\.)+[0-9]+" OPENDDS_VERSION ${VERSION_FILE_CONTENT})
endif()

set(ACEUTIL_TOP_LEVEL_FOLDER_NAME OpenDDS)
set(ACEUTIL_TOP_LEVEL_FOLDER_DIR ${CMAKE_CURRENT_SOURCE_DIR})

include(cmake/opendds_options.cmake)
include(cmake/dds_idl_sources.cmake)


ace_add_package(OpenDDS
  VERSION ${OPENDDS_VERSION}
)

if (MSVC)
  add_compile_options("/bigobj")
endif(MSVC)

if (${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
  ## shmem transport not working on MacOS, disable them all together
  set(TEST_EXCLUDE_LABELS SHMEM)
endif()

enable_testing()

if (HOSTTOOLS_ONLY)
  set(OPENDDS_SUBDIRS "dds/idl")
else()
  set(OPENDDS_SUBDIRS "dds;tools;java;examples;tests;performance-tests;DevGuideExamples" CACHE STRING "")
endif()

foreach(subdir ${OPENDDS_SUBDIRS})
  add_subdirectory(${subdir})
endforeach()

add_subdirectory(bin/PerlDDS)
add_subdirectory(docs)

ace_install_package(OpenDDS
  CONFIG_OPTIONS ${DDS_OPTIONS}
  PREREQUISITE TAO
  EXTRA_CMAKE_FILES cmake/dds_idl_sources.cmake
)

include(cmake/export_opendds_hosttools.cmake)
## This line must be the last of the file, so we can run the post install script
## in the correct order
add_subdirectory(cmake)
