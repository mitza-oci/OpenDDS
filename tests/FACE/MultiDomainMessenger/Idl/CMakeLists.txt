
set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)
ace_add_lib(FaceMultiDomainMessengerIdl
  OUTPUT_NAME FaceMultiDomainMessengerIdl
  DEFINE_SYMBOL FACEMESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
dds_idl_sources(
  TARGETS FaceMultiDomainMessengerIdl
  DDS_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  TAO_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  IDL_FILES FaceMessage.idl
)

