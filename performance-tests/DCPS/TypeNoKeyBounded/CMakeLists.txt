
set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)
ace_add_lib(DCPS_Perf_TypeNoKeyBounded
  OUTPUT_NAME DCPS_Perf_TypeNoKeyBounded
  DEFINE_SYMBOL PTTYPELIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DCPS_Perf_TypeNoKeyBounded
  DDS_IDL_FLAGS -Wb,export_macro=PTTypeLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=PTTypeLib_Export
                -Wb,export_include=PTTypeLib_Export.h
                -SS
  IDL_FILES PTDef.idl
)

