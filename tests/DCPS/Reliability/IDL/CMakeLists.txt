

add_ace_lib(Reliability
  OUTPUT_NAME Reliability
  FOLDER tests/DCPS/Reliability/IDL
  DEFINE_SYMBOL RELIABILITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS Reliability
  DDS_IDL_FLAGS -Wb,export_macro=Reliability_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Reliability_Export.h
                -Wb,stub_export_macro=Reliability_Export
                -SS
  IDL_FILES Reliability.idl
)
