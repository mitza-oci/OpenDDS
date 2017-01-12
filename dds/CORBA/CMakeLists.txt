
project(CORBA CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT ACE_DIR)
  find_package(ACE REQUIRED CONFIG)
endif()
add_subdirectory(tao)
