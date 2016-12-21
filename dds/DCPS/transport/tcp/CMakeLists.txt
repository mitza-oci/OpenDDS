if (NO_OPENDDS_SAFETY_PROFILE)
  add_package_lib(OpenDDS_Tcp
    PACKAGE OpenDDS
    DEFINE_SYMBOL OPENDDS_TCP_BUILD_DLL
    PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
  )

  glob_target_cxx_sources(OpenDDS_Tcp)
endif()