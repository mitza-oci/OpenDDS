
project(FaceReliabilitySubscriber CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(FaceReliabilitySubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/Reliability/Subscriber
  ASPECTS FACE
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../../Messenger
                      ${CMAKE_CURRENT_BINARY_DIR}/../../Messenger
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceReliabilitySubscriber
  SOURCE_FILES Subscriber.cpp
)

