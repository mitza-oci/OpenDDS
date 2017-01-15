

ace_add_exe(FaceMultiDomainMessengerSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/MultiDomainMessenger/Subscriber
  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMultiDomainMessengerSubscriber
  SOURCE_FILES Subscriber.cpp
)

