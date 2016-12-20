
project(CallbackAndReceiveSubscriber CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(CallbackAndReceiveSubscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
  FOLDER tests/FACE/CallbackAndReceive/Subscriber
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../../Messenger
                      ${CMAKE_CURRENT_BINARY_DIR}/../../Messenger
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
