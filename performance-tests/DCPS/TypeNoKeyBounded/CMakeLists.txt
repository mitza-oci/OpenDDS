

add_ace_lib(DCPS_Perf_TypeNoKeyBounded
  OUTPUT_NAME DCPS_Perf_TypeNoKeyBounded
  FOLDER performance-tests/DCPS/TypeNoKeyBounded
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DCPS_Perf_TypeNoKeyBounded
  DDS_IDL_FLAGS -Wb,export_macro=PTTypeLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=PTTypeLib_Export
                -Wb,export_include=PTTypeLib_Export.h
                -SS
  IDL_FILES PTDef.idl
)
