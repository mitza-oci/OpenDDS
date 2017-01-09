
project(DCPS CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Messenger_IOGR_Imr)
add_subdirectory(ishapes)
add_subdirectory(DistributedContent)
add_subdirectory(Messenger_Imr)
add_subdirectory(IntroductionToOpenDDS)
