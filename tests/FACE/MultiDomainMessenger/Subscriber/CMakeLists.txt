

add_ace_exe(FaceMultiDomainMessengerSubscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
  FOLDER tests/FACE/MultiDomainMessenger/Subscriber
  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
