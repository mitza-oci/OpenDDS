

ace_add_lib(FaceHeaderTestIdl
  OUTPUT_NAME FaceHeaderTestIdl
  FOLDER tests/FACE/Header/Idl
  ASPECTS FACE
  DEFINE_SYMBOL FACEHEADERTEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS FaceHeaderTestIdl
  ASPECTS FACE
  DDS_IDL_FLAGS -Wb,export_include=FaceHeaderTest_Export.h
                -Wb,export_macro=FaceHeaderTest_Export
  TAO_IDL_FLAGS -Wb,export_include=FaceHeaderTest_Export.h
                -Wb,export_macro=FaceHeaderTest_Export
  IDL_FILES FaceHeaderTestMsg.idl
)

