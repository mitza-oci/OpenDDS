
set(CMAKE_INCLUDE_CURRENT_DIR ON)
ace_add_exe(FaceMessengerPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMessengerPublisher
  SOURCE_FILES Publisher.cpp
)

