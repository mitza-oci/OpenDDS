
set(CMAKE_INCLUDE_CURRENT_DIR ON)
ace_add_exe(FaceMultiDomainMessengerSubscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES FaceMultiDomainMessengerIdl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMultiDomainMessengerSubscriber
  SOURCE_FILES Subscriber.cpp
)

