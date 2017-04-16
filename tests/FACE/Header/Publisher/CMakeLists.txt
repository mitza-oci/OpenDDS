
set(CMAKE_INCLUDE_CURRENT_DIR ON)
ace_add_exe(FaceHeaderPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES FaceHeaderTestIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceHeaderPublisher
  SOURCE_FILES Publisher.cpp
)

