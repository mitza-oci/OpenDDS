
project(FaceMessenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(FaceMessenger_Idl
  OUTPUT_NAME FaceMessenger_Idl
  FOLDER DevGuideExamples/FACE/Simple
  ASPECTS FACE
  DEFINE_SYMBOL FACEMESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS FaceMessenger_Idl
  ASPECTS FACE
  DDS_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  TAO_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  IDL_FILES FaceMessage.idl
)


add_ace_exe(FaceMessenger_Publisher
  OUTPUT_NAME publisher
  FOLDER DevGuideExamples/FACE/Simple
  ASPECTS FACE
  LINK_LIBRARIES FaceMessenger_Idl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceMessenger_Publisher
  SOURCE_FILES Publisher.cpp
)


add_ace_exe(FaceMessenger_Subscriber
  OUTPUT_NAME subscriber
  FOLDER DevGuideExamples/FACE/Simple
  ASPECTS FACE
  LINK_LIBRARIES FaceMessenger_Idl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceMessenger_Subscriber
  SOURCE_FILES Subscriber.cpp
)


add_ace_exe(FaceMessenger_Callbacksubscriber
  OUTPUT_NAME callback_subscriber
  FOLDER DevGuideExamples/FACE/Simple
  ASPECTS FACE
  LINK_LIBRARIES FaceMessenger_Idl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(FaceMessenger_Callbacksubscriber
  SOURCE_FILES CallbackSubscriber.cpp
)

