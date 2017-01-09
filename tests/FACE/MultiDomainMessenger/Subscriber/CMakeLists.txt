

ace_add_exe(FaceMultiDomainMessengerSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/MultiDomainMessenger/Subscriber
  ASPECTS FACE
  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMultiDomainMessengerSubscriber
  SOURCE_FILES Subscriber.cpp
)

