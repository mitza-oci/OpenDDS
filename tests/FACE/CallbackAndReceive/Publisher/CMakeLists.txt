
project(CallbackAndReceivePublisher CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(CallbackAndReceivePublisher
  OUTPUT_NAME publisher
  FOLDER tests/FACE/CallbackAndReceive/Publisher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../../Messenger
                      ${CMAKE_CURRENT_BINARY_DIR}/../../Messenger
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(CallbackAndReceivePublisher
  SOURCE_FILES Publisher.cpp
)

