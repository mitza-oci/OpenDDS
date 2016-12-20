

add_ace_exe(FacePartitionSubscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
  FOLDER tests/FACE/Partition/Subscriber
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../
                      ${CMAKE_CURRENT_BINARY_DIR}/../
  LINK_LIBRARIES FacePartitionIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
