ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(OpenDDS_Udp
  PACKAGE OpenDDS
  FOLDER OpenDDS/dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_UDP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_Udp
  SOURCE_FILES Udp.cpp
               UdpDataLink.cpp
               UdpInst.cpp
               UdpLoader.cpp
               UdpReceiveStrategy.cpp
               UdpSendStrategy.cpp
               UdpTransport.cpp
  HEADER_FILES Udp.h
               UdpDataLink.h
               UdpDataLink_rch.h
               UdpInst.h
               UdpInst_rch.h
               UdpLoader.h
               UdpReceiveStrategy.h
               UdpReceiveStrategy_rch.h
               UdpSendStrategy.h
               UdpSendStrategy_rch.h
               UdpTransport.h
               Udp_Export.h
  INLINE_FILES UdpDataLink.inl
)

