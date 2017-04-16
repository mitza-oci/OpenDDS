
set(CMAKE_INCLUDE_CURRENT_DIR ON)
ace_add_exe(FacePartitionSubscriber
  OUTPUT_NAME subscriber

  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../
                      ${CMAKE_CURRENT_BINARY_DIR}/../
  LINK_LIBRARIES FacePartitionIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FacePartitionSubscriber
  SOURCE_FILES Subscriber.cpp
)

