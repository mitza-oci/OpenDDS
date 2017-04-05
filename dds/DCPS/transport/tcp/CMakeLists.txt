ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(OpenDDS_Tcp
  PACKAGE OpenDDS
  FOLDER OpenDDS/dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_TCP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_Tcp
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
  HEADER_FILES Tcp.h
               TcpAcceptor.h
               TcpConnection.h
               TcpConnectionReplaceTask.h
               TcpConnection_rch.h
               TcpDataLink.h
               TcpDataLink_rch.h
               TcpInst.h
               TcpInst_rch.h
               TcpLoader.h
               TcpReceiveStrategy.h
               TcpReceiveStrategy_rch.h
               TcpReconnectTask.h
               TcpSendStrategy.h
               TcpSendStrategy_rch.h
               TcpSynchResource.h
               TcpTransport.h
               TcpTransport_rch.h
               Tcp_export.h
               Tcp_pch.h
  INLINE_FILES TcpConnection.inl
               TcpDataLink.inl
               TcpInst.inl
               TcpReceiveStrategy.inl
)