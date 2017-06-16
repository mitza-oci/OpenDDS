
ace_add_lib(OpenDDS_Rtps
  PACKAGE OpenDDS
  FOLDER OpenDDS/dds/DCPS
  DEFINE_SYMBOL OPENDDS_RTPS_BUILD_DLL
  PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_Rtps
  SOURCE_FILES GuidGenerator.cpp
               ParameterListConverter.cpp
               RtpsDiscovery.cpp
               Sedp.cpp
               Spdp.cpp
               md5.cpp
  HEADER_FILES BaseMessageTypes.h
               BaseMessageUtils.h
               GuidGenerator.h
               MessageTypes.h
               ParameterListConverter.h
               RtpsDiscovery.h
               Sedp.h
               Spdp.h
               md5.h
               rtps_export.h
)


if (OPENDDS_SAFETY_PROFILE)
  dds_idl_sources(
    TARGETS OpenDDS_Rtps
    NO_TAO_IDL
    DDS_IDL_FLAGS -Wb,export_macro=OpenDDS_Rtps_Export -Wb,export_include=dds/DCPS/RTPS/rtps_export.h -SI -Lspcpp
    IDL_FILES RtpsCore.idl
  )
else()
  dds_idl_sources(
    TARGETS OpenDDS_Rtps
    DDS_IDL_FLAGS -Wb,export_macro=OpenDDS_Rtps_Export -Wb,export_include=dds/DCPS/RTPS/rtps_export.h
    TAO_IDL_FLAGS -Wb,export_macro=OpenDDS_Rtps_Export -Wb,export_include=dds/DCPS/RTPS/rtps_export.h
    IDL_FILES RtpsCore.idl
  )
endif()