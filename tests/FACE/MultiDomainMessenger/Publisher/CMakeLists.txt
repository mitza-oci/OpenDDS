

add_ace_exe(FaceMultiDomainMessengerPublisher
  OUTPUT_NAME publisher
  FOLDER tests/FACE/MultiDomainMessenger/Publisher
  ASPECTS FACE
  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceMultiDomainMessengerPublisher
  SOURCE_FILES Publisher.cpp
)

