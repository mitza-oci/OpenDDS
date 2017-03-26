
ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(OpenDDS_Shmem
  PACKAGE OpenDDS
  FOLDER dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_SHMEM_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_Shmem
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