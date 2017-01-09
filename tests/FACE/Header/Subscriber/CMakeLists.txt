

add_ace_exe(FaceHeaderSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/FACE/Header/Subscriber
  ASPECTS FACE
  LINK_LIBRARIES FaceHeaderTestIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceHeaderSubscriber
  SOURCE_FILES Subscriber.cpp
)

