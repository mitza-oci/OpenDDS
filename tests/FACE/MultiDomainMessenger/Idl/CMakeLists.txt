

add_ace_lib(FaceMultiDomainMessengerIdl
  OUTPUT_NAME FaceMultiDomainMessengerIdl
  FOLDER tests/FACE/MultiDomainMessenger/Idl
  ASPECTS FACE
  DEFINE_SYMBOL FACEMESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS FaceMultiDomainMessengerIdl
  ASPECTS FACE
  DDS_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  TAO_IDL_FLAGS -Wb,export_include=FaceMessenger_Export.h
                -Wb,export_macro=FaceMessenger_Export
  IDL_FILES FaceMessage.idl
)

