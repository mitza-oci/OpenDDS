

ace_add_exe(FaceMultiDomainMessengerPublisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMultiDomainMessengerPublisher
  SOURCE_FILES Publisher.cpp
)

