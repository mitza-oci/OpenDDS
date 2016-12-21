
if (NO_OPENDDS_SAFETY_PROFILE)

  file(GLOB idls_files ${CMAKE_CURRENT_LIST_DIR}/*.idl)

  dds_idl_sources(
    TARGETS OpenDDS_Dcps
    NO_TAO_IDL
    DDS_IDL_FLAGS ${dcps_flags} -SI -Wb,tao_include_prefix=tao/
    IDL_FILES ${idls_files}
  )

endif()