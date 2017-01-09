

ace_add_exe(FaceMessengerPublisher
  OUTPUT_NAME publisher
  FOLDER tests/FACE/Messenger/Publisher
  ASPECTS FACE
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMessengerPublisher
  SOURCE_FILES Publisher.cpp
)

