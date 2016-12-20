
add_package_lib(OpenDDS_Rtps
  PACKAGE OpenDDS
  DEFINE_SYMBOL OPENDDS_RTPS_BUILD_DLL
  PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

glob_target_files(OpenDDS_Rtps)

add_dds_idl_files(
  TARGETS OpenDDS_Rtps
  DDS_IDL_FLAGS -Wb,export_macro=OpenDDS_Rtps_Export -Wb,export_include=dds/DCPS/RTPS/rtps_export.h
  TAO_IDL_FLAGS -Wb,export_macro=OpenDDS_Rtps_Export -Wb,export_include=dds/DCPS/RTPS/rtps_export.h
  IDL_FILES RtpsCore.idl
)
