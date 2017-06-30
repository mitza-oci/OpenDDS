ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(OpenDDS_Tcp
  PACKAGE OpenDDS
  FOLDER OpenDDS/dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_TCP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_Tcp
  GLOB_HEADERS
  SOURCE_FILES Tcp.cpp
               TcpAcceptor.cpp
               TcpConnection.cpp
               TcpConnectionReplaceTask.cpp
               TcpDataLink.cpp
               TcpInst.cpp
               TcpLoader.cpp
               TcpReceiveStrategy.cpp
               TcpReconnectTask.cpp
               TcpSendStrategy.cpp
               TcpSynchResource.cpp
               TcpTransport.cpp
               Tcp_pch.cpp
)