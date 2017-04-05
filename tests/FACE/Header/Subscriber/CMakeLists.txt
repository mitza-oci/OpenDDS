

ace_add_exe(FaceHeaderSubscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES FaceHeaderTestIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceHeaderSubscriber
  SOURCE_FILES Subscriber.cpp
)

