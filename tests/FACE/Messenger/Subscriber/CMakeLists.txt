

ace_add_exe(FaceMessengerSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/Messenger/Subscriber
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMessengerSubscriber
  SOURCE_FILES Subscriber.cpp
)

