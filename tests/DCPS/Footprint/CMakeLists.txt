
project(Footprint CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_Footprint_Idl
  OUTPUT_NAME DDS_Footprint_Idl
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Footprint_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Footprint_Rtpspublisher
  OUTPUT_NAME rtpspublisher

  LINK_LIBRARIES DDS_Footprint_Idl
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(DDS_Footprint_Rtpspublisher
  SOURCE_FILES Writer.cpp
               rtpspublisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_Footprint_Rtpssubscriber
  OUTPUT_NAME rtpssubscriber

  LINK_LIBRARIES DDS_Footprint_Idl
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(DDS_Footprint_Rtpssubscriber
  SOURCE_FILES DataReaderListener.cpp
               rtpssubscriber.cpp
  HEADER_FILES DataReaderListener.h
)


ace_add_exe(DDS_Footprint_Tcppublisher
  OUTPUT_NAME tcppublisher

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Footprint_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Footprint_Tcppublisher
  SOURCE_FILES Writer.cpp
               tcppublisher.cpp
  HEADER_FILES Writer.h
)
ace_target_cxx_sources(DDS_Footprint_Tcppublisher
  SOURCE_FILES Writer.cpp
               tcppublisher.cpp
  HEADER_FILES Writer.h
)



ace_add_exe(DDS_Footprint_Tcpsubscriber
  OUTPUT_NAME tcpsubscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Footprint_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Footprint_Tcpsubscriber
  SOURCE_FILES DataReaderListener.cpp
               tcpsubscriber.cpp
  HEADER_FILES DataReaderListener.h
)

