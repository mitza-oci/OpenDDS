

add_ace_exe(FaceHeaderPublisher
  OUTPUT_NAME publisher
  FOLDER tests/FACE/Header/Publisher
  ASPECTS FACE
  LINK_LIBRARIES FaceHeaderTestIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceHeaderPublisher
  SOURCE_FILES Publisher.cpp
)

