
project(raw_tcp CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT TARGET ACE)
  find_package(ACE REQUIRED CONFIG)
endif()

if (WIN32)
  string(LENGTH "${CMAKE_CURRENT_BINARY_DIR}" binary_dir_len)
  if (binary_dir_len GREATER 100)
    set(CURRENT_BINARY_DIR_TOO_LONG ON)
  endif()
endif(WIN32)

ace_requires("NOT CURRENT_BINARY_DIR_TOO_LONG")

add_subdirectory(publisher)
add_subdirectory(subscriber)
