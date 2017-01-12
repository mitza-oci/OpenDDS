

add_ace_lib(OpenDDS_Rtps_Udp
  PACKAGE OpenDDS
  FOLDER dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_RTPS_UDP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Rtps
)

target_cxx_sources(OpenDDS_Rtps_Udp
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
  HEADER_FILES RtpsCustomizedElement.h
               RtpsSampleHeader.h
               RtpsTransportHeader.h
               RtpsUdp.h
               RtpsUdpDataLink.h
               RtpsUdpDataLink_rch.h
               RtpsUdpInst.h
               RtpsUdpInst_rch.h
               RtpsUdpLoader.h
               RtpsUdpReceiveStrategy.h
               RtpsUdpReceiveStrategy_rch.h
               RtpsUdpSendStrategy.h
               RtpsUdpSendStrategy_rch.h
               RtpsUdpTransport.h
               Rtps_Udp_Export.h
  INLINE_FILES RtpsCustomizedElement.inl
               RtpsSampleHeader.inl
               RtpsTransportHeader.inl
               RtpsUdpDataLink.inl
)