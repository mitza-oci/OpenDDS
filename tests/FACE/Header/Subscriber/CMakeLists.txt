

add_ace_exe(FaceHeaderSubscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
  FOLDER tests/FACE/Header/Subscriber
  LINK_LIBRARIES FaceHeaderTestIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
