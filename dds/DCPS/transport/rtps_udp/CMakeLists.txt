

add_package_lib(OpenDDS_Rtps_Udp
  PACKAGE OpenDDS
  DEFINE_SYMBOL OPENDDS_RTPS_UDP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Rtps
)

glob_target_files(OpenDDS_Rtps_Udp)