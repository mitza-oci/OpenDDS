if (NO_OPENDDS_SAFETY_PROFILE)

  add_package_lib(OpenDDS_InfoRepoDiscovery
    PACKAGE OpenDDS
    DEFINE_SYMBOL OPENDDS_INFOREPODISCOVERY_BUILD_DLL
    INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} ${DDS_ROOT}/dds
    PUBLIC_LINK_LIBRARIES OpenDDS_Dcps OpenDDS_Tcp
  )

  glob_target_files(OpenDDS_InfoRepoDiscovery)

  add_tao_idl_files(
    TARGETS OpenDDS_InfoRepoDiscovery
    IDL_FLAGS -Wb,export_macro=OpenDDS_InfoRepoDiscovery_Export -Wb,export_include=dds/DCPS/InfoRepoDiscovery/InfoRepoDiscovery_Export.h
    IDL_FILES Info.idl
              DataReaderRemote.idl
              DataWriterRemote.idl
  )


endif()