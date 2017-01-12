
project(GetConnectionParametersSubscriber CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(GetConnectionParametersSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/GetConnectionParameters/Subscriber
  ASPECTS FACE
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../../Messenger
                      ${CMAKE_CURRENT_BINARY_DIR}/../../Messenger
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(GetConnectionParametersSubscriber
  SOURCE_FILES Subscriber.cpp
)

