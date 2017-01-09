

add_ace_exe(FacePartitionPublisher
  OUTPUT_NAME publisher
  FOLDER tests/FACE/Partition/Publisher
  ASPECTS FACE
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/..
                      ${CMAKE_CURRENT_BINARY_DIR}/..
  LINK_LIBRARIES FacePartitionIdl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FacePartitionPublisher
  SOURCE_FILES Publisher.cpp
)

