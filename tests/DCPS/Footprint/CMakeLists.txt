
project(Footprint CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Footprint_Idl
  OUTPUT_NAME DDS_Footprint_Idl
  FOLDER tests/DCPS/Footprint
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


add_ace_exe(DDS_Footprint_Rtpspublisher
  OUTPUT_NAME rtpspublisher
  FOLDER tests/DCPS/Footprint
  LINK_LIBRARIES DDS_Footprint_Idl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(DDS_Footprint_Rtpspublisher
  SOURCE_FILES Writer.cpp
               rtpspublisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_Footprint_Rtpssubscriber
  OUTPUT_NAME rtpssubscriber
  FOLDER tests/DCPS/Footprint
  LINK_LIBRARIES DDS_Footprint_Idl
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(DDS_Footprint_Rtpssubscriber
  SOURCE_FILES DataReaderListener.cpp
               rtpssubscriber.cpp
  HEADER_FILES DataReaderListener.h
)


add_ace_exe(DDS_Footprint_Tcppublisher
  OUTPUT_NAME tcppublisher
  FOLDER tests/DCPS/Footprint
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Footprint_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Footprint_Tcppublisher
  SOURCE_FILES Writer.cpp
               tcppublisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_Footprint_Tcpsubscriber
  OUTPUT_NAME tcpsubscriber
  FOLDER tests/DCPS/Footprint
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Footprint_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Footprint_Tcpsubscriber
  SOURCE_FILES DataReaderListener.cpp
               tcpsubscriber.cpp
  HEADER_FILES DataReaderListener.h
)

