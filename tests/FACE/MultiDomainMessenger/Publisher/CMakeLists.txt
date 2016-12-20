

add_ace_exe(FaceMultiDomainMessengerPublisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER tests/FACE/MultiDomainMessenger/Publisher
  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
