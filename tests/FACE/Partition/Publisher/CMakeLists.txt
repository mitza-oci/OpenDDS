

add_ace_exe(FacePartitionPublisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER tests/FACE/Partition/Publisher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/..
                      ${CMAKE_CURRENT_BINARY_DIR}/..
  LINK_LIBRARIES FacePartitionIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
