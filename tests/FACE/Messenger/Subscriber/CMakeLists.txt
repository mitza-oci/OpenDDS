

add_ace_exe(FaceMessengerSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/Messenger/Subscriber
  ASPECTS FACE
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceMessengerSubscriber
  SOURCE_FILES Subscriber.cpp
)

