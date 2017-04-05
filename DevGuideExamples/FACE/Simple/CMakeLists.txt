
project(FaceMessenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(FaceMessenger_Idl
  OUTPUT_NAME FaceMessenger_Idl

  DEFINE_SYMBOL FACEMESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
dds_idl_sources(
  TARGETS FaceMessenger_Idl
  DDS_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  TAO_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  IDL_FILES FaceMessage.idl
)


ace_add_exe(FaceMessenger_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_FACE
                 FaceMessenger_Idl
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMessenger_Publisher
  SOURCE_FILES Publisher.cpp
)


ace_add_exe(FaceMessenger_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_FACE
                 FaceMessenger_Idl
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMessenger_Subscriber
  SOURCE_FILES Subscriber.cpp
)


ace_add_exe(FaceMessenger_Callbacksubscriber
  OUTPUT_NAME callback_subscriber

  LINK_LIBRARIES OpenDDS_FACE
                 FaceMessenger_Idl
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(FaceMessenger_Callbacksubscriber
  SOURCE_FILES CallbackSubscriber.cpp
)

