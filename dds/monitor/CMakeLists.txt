if (NO_OPENDDS_SAFETY_PROFILE)

  add_package_lib(OpenDDS_monitor
    PACKAGE OpenDDS
    DEFINE_SYMBOL OPENDDS_MONITOR_BUILD_DLL
    INCLUDE_DIRECTORIES ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}
    PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
  )

  add_dds_idl_files(
    TARGETS OpenDDS_monitor
    DDS_IDL_FLAGS -Wb,export_macro=OpenDDS_monitor_Export
    TAO_IDL_FLAGS -Wb,export_macro=OpenDDS_monitor_Export -Wb,export_include=dds/monitor/monitor_export.h
    IDL_FILES monitor.idl
  )

  glob_target_files(OpenDDS_monitor)

  if (MSVC)
    target_compile_options(OpenDDS_monitor /bigobj)
  endif(MSVC)

endif(NO_OPENDDS_SAFETY_PROFILE)