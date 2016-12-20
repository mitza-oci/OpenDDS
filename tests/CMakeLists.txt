
project(tests CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(transport)
add_subdirectory(FACE)
add_subdirectory(Utils)
add_subdirectory(DCPS)
