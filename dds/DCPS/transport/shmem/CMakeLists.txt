
ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(OpenDDS_Shmem
  PACKAGE OpenDDS
  FOLDER OpenDDS/dds/DCPS/transport
  DEFINE_SYMBOL OPENDDS_SHMEM_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_Shmem
  GLOB_HEADERS
  SOURCE_FILES Shmem.cpp
               ShmemDataLink.cpp
               ShmemInst.cpp
               ShmemLoader.cpp
               ShmemReceiveStrategy.cpp
               ShmemSendStrategy.cpp
               ShmemTransport.cpp
)