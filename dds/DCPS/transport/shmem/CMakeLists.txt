
requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(OpenDDS_Shmem
  PACKAGE OpenDDS
  FOLDER dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_SHMEM_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

target_cxx_sources(OpenDDS_Shmem
  SOURCE_FILES Shmem.cpp
               ShmemDataLink.cpp
               ShmemInst.cpp
               ShmemLoader.cpp
               ShmemReceiveStrategy.cpp
               ShmemSendStrategy.cpp
               ShmemTransport.cpp
  HEADER_FILES Shmem.h
               ShmemDataLink.h
               ShmemDataLink_rch.h
               ShmemInst.h
               ShmemInst_rch.h
               ShmemLoader.h
               ShmemReceiveStrategy.h
               ShmemReceiveStrategy_rch.h
               ShmemSendStrategy.h
               ShmemSendStrategy_rch.h
               ShmemTransport.h
               Shmem_Export.h
  INLINE_FILES ShmemDataLink.inl
)