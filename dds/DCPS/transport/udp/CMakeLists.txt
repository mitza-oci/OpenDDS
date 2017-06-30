ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(OpenDDS_Udp
  PACKAGE OpenDDS
  FOLDER OpenDDS/dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_UDP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_Udp
  GLOB_HEADERS
  SOURCE_FILES Udp.cpp
               UdpDataLink.cpp
               UdpInst.cpp
               UdpLoader.cpp
               UdpReceiveStrategy.cpp
               UdpSendStrategy.cpp
               UdpTransport.cpp
)

