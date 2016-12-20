

add_ace_exe(FaceMessengerPublisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER tests/FACE/Messenger/Publisher
  LINK_LIBRARIES FaceMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
