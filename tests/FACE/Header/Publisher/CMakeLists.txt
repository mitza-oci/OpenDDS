

ace_add_exe(FaceHeaderPublisher
  OUTPUT_NAME publisher
  FOLDER tests/FACE/Header/Publisher
  LINK_LIBRARIES FaceHeaderTestIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceHeaderPublisher
  SOURCE_FILES Publisher.cpp
)

