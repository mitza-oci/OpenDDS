
project(DCPS CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Messenger_Imr)
add_subdirectory(IntroductionToOpenDDS)
add_subdirectory(Messenger_IOGR_Imr)
add_subdirectory(DistributedContent)
add_subdirectory(ishapes)
