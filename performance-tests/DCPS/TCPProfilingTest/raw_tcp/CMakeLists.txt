
project(raw_tcp CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT TARGET ACE)
  find_package(ACE REQUIRED CONFIG)
endif()
add_subdirectory(publisher)
add_subdirectory(subscriber)
