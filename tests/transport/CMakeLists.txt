
project(transport CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(simple)
add_subdirectory(error_handling)
add_subdirectory(rtps)
add_subdirectory(rtps_reliability)
