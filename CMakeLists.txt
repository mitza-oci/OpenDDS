cmake_minimum_required(VERSION 3.8)
project(OpenDDS CXX)

if (NOT OPENDDS_VERSION)
  file(READ "VERSION" VERSION_FILE_CONTENT)
  string(REGEX MATCH "([0-9]\\.)+[0-9]+" OPENDDS_VERSION ${VERSION_FILE_CONTENT})
endif()


option(BUILD_SHARED_LIBS "" ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
include(find_or_download_tao)
include(opendds_options)
include(dds_idl_sources)

ace_try_enable_ccache()
ace_try_set_cxx_visibility_hidden()

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
  set(OpenDDS_SUBDIRS "dds/idl")
else()
  set(OpenDDS_SUBDIRS "dds;tools;java;examples;tests;performance-tests;DevGuideExamples" CACHE STRING "")
endif()

foreach(subdir ${OpenDDS_SUBDIRS})
  add_subdirectory(${subdir})
endforeach()

add_subdirectory(bin/PerlDDS)
add_subdirectory(docs)

ace_install_package(OpenDDS
  CONFIG_OPTIONS ${DDS_OPTIONS}
  PREREQUISITE TAO
  EXTRA_CMAKE_FILES cmake/dds_idl_sources.cmake
)

include(export_opendds_hosttools)
## This line must be the last of the file, so we can run the post install script
## in the correct order
add_subdirectory(cmake)
