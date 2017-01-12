

add_ace_lib(OpenDDS_Multicast
  PACKAGE OpenDDS
  FOLDER dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_MULTICAST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

target_cxx_sources(OpenDDS_Multicast
  SOURCE_FILES BestEffortSession.cpp
               BestEffortSessionFactory.cpp
               Multicast.cpp
               MulticastDataLink.cpp
               MulticastInst.cpp
               MulticastLoader.cpp
               MulticastReceiveStrategy.cpp
               MulticastSendStrategy.cpp
               MulticastSession.cpp
               MulticastSessionFactory.cpp
               MulticastTransport.cpp
               ReliableSession.cpp
               ReliableSessionFactory.cpp
  HEADER_FILES BestEffortSession.h
               BestEffortSessionFactory.h
               Multicast.h
               MulticastDataLink.h
               MulticastDataLink_rch.h
               MulticastInst.h
               MulticastInst_rch.h
               MulticastLoader.h
               MulticastReceiveStrategy.h
               MulticastReceiveStrategy_rch.h
               MulticastSendStrategy.h
               MulticastSendStrategy_rch.h
               MulticastSession.h
               MulticastSessionFactory.h
               MulticastSessionFactory_rch.h
               MulticastSession_rch.h
               MulticastTransport.h
               MulticastTypes.h
               Multicast_Export.h
               ReliableSession.h
               ReliableSessionFactory.h
  INLINE_FILES MulticastDataLink.inl
               MulticastSession.inl
)