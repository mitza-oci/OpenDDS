
project(DistributedContent CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(BUILT_IN_TOPICS NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DDS_DistributedContent_Node
  OUTPUT_NAME node
  FOLDER examples/DCPS/DistributedContent
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(DDS_DistributedContent_Node
  SOURCE_FILES AbstractionLayer.cpp
               ApplicationLevel.cpp
               FileInfoListener.cpp
               main.cpp
  HEADER_FILES AbstractionLayer.h
               ApplicationLevel.h
               FileInfoListener.h
)

dds_idl_sources(
  TARGETS DDS_DistributedContent_Node
  IDL_FILES FileInfo.idl
)

