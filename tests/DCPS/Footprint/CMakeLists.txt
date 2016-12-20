
project(Footprint CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Footprint_idl
  OUTPUT_NAME DDS_Footprint_idl
  FOLDER tests/DCPS/Footprint
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_Footprint_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Footprint_RtpsPublisher
  OUTPUT_NAME rtpspublisher
  SOURCE_FILES rtpspublisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Footprint
  LINK_LIBRARIES DDS_Footprint_idl
                 OpenDDS_Rtps_Udp
)

add_ace_exe(DDS_Footprint_RtpsSubscriber
  OUTPUT_NAME rtpssubscriber
  SOURCE_FILES rtpssubscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Footprint
  LINK_LIBRARIES DDS_Footprint_idl
                 OpenDDS_Rtps_Udp
)

add_ace_exe(DDS_Footprint_TcpPublisher
  OUTPUT_NAME tcppublisher
  SOURCE_FILES tcppublisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Footprint
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Footprint_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Footprint_TcpSubscriber
  OUTPUT_NAME tcpsubscriber
  SOURCE_FILES tcpsubscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Footprint
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Footprint_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
