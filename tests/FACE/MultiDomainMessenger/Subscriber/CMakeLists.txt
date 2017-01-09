

add_ace_exe(FaceMultiDomainMessengerSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/MultiDomainMessenger/Subscriber
  ASPECTS FACE
  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceMultiDomainMessengerSubscriber
  SOURCE_FILES Subscriber.cpp
)

