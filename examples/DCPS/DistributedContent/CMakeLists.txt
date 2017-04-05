
project(DistributedContent CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_BUILT_IN_TOPICS "NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(DDS_DistributedContent_Node
  OUTPUT_NAME node

  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_DistributedContent_Node
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

