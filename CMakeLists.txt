cmake_minimum_required(VERSION 3.6)
project(OpenDDS CXX)

include(cmake/find_or_download_tao.cmake)

if (NOT OPENDDS_VERSION)
  file(READ "VERSION" VERSION_FILE_CONTENT)
  string(REGEX MATCH "([0-9]\\.)+[0-9]+" OPENDDS_VERSION ${VERSION_FILE_CONTENT})
endif()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
option(BUILD_SHARED_LIBS "" ON)
set(CMAKE_LINK_DEPENDS_NO_SHARED ON)

include(cmake/opendds_options.cmake)
include(cmake/dds_idl_sources.cmake)


ace_add_package(OpenDDS
  VERSION ${OPENDDS_VERSION}
)

enable_testing()

if (MSVC)
  add_compile_options("/bigobj")
endif(MSVC)

if (${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
  ## shmem transport not working on MacOS, disable them all together
  set(TEST_EXCLUDE_LABELS SHMEM)
endif()

add_subdirectory(dds)
ace_add_optional_subdirectory(tools)
ace_add_optional_subdirectory(examples/DCPS)
ace_add_optional_subdirectory(tests)
ace_add_optional_subdirectory(performance-tests)
ace_add_optional_subdirectory(DevGuideExamples)
ace_add_optional_subdirectory(java)
add_subdirectory(bin/PerlDDS)
add_subdirectory(docs)

ace_install_package(OpenDDS
  CONFIG_OPTIONS ${DDS_OPTIONS}
  PREREQUISITE TAO
  EXTRA_CMAKE_FILES cmake/dds_idl_sources.cmake
)


## This line must be the last of the file, so we can run the post install script
## in the correct order
add_subdirectory(cmake)
