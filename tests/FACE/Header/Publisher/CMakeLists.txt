

add_ace_exe(FaceHeaderPublisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER tests/FACE/Header/Publisher
  LINK_LIBRARIES FaceHeaderTestIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
