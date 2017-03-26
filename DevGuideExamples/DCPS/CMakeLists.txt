
project(DCPS CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Messenger.minimal)
add_subdirectory(Messenger_ZeroCopy)
add_subdirectory(Messenger)
