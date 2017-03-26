
project(Compiler CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(idl_test3_lib)
add_subdirectory(idl_test3_main)
add_subdirectory(idl_test2_lib)
add_subdirectory(idl_test_fixed)
add_subdirectory(idl_test1_lib)
add_subdirectory(idl_test1_main)
