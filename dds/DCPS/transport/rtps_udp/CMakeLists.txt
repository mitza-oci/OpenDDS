

ace_add_lib(OpenDDS_Rtps_Udp
  PACKAGE OpenDDS
  FOLDER OpenDDS/dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_RTPS_UDP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Rtps
)

ace_target_cxx_sources(OpenDDS_Rtps_Udp
  GLOB_HEADERS
  SOURCE_FILES RtpsCustomizedElement.cpp
               RtpsSampleHeader.cpp
               RtpsTransportHeader.cpp
               RtpsUdp.cpp
               RtpsUdpDataLink.cpp
               RtpsUdpInst.cpp
               RtpsUdpLoader.cpp
               RtpsUdpReceiveStrategy.cpp
               RtpsUdpSendStrategy.cpp
               RtpsUdpTransport.cpp
)