
project(FaceMessenger CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(FaceMessenger_idl
  OUTPUT_NAME FaceMessenger_idl
  FOLDER DevGuideExamples/FACE/Simple
  DEFINE_SYMBOL FACEMESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
add_face_idl_files(
  TARGETS FaceMessenger_idl
  DDS_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  TAO_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  IDL_FILES FaceMessage.idl
)

add_ace_exe(FaceMessenger_publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER DevGuideExamples/FACE/Simple
  LINK_LIBRARIES FaceMessenger_idl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)

add_ace_exe(FaceMessenger_subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
  FOLDER DevGuideExamples/FACE/Simple
  LINK_LIBRARIES FaceMessenger_idl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)

add_ace_exe(FaceMessenger_callbacksubscriber
  OUTPUT_NAME callback_subscriber
  SOURCE_FILES CallbackSubscriber.cpp
  FOLDER DevGuideExamples/FACE/Simple
  LINK_LIBRARIES FaceMessenger_idl
                 OpenDDS_FACE
                 OpenDDS_Rtps_Udp
)
