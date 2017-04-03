file(GLOB idls_files ${CMAKE_CURRENT_LIST_DIR}/*.idl)

if (OPENDDS_SAFETY_PROFILE)
  ace_add_lib(OpenDDS_CorbaSeq
    PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
    PACKAGE OpenDDS
  )

  dds_idl_sources(
    TARGETS OpenDDS_CorbaSeq
    NO_TAO_IDL
    DDS_IDL_FLAGS ${dcps_flags} -SI -Wb,tao_include_prefix=tao/
    IDL_FILES ${idls_files}
  )
else()
  dds_idl_sources(
    TARGETS OpenDDS_Dcps
    NO_TAO_IDL
    DDS_IDL_FLAGS ${dcps_flags} -SI -Wb,tao_include_prefix=tao/
    IDL_FILES ${idls_files}
  )

endif()