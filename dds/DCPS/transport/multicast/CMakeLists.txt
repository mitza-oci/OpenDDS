

add_package_lib(OpenDDS_Multicast
  PACKAGE OpenDDS
  DEFINE_SYMBOL OPENDDS_MULTICAST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

glob_target_cxx_sources(OpenDDS_Multicast)