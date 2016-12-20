
project(DistributedContent CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

add_ace_exe(DDS_DistributedContent_Node
  OUTPUT_NAME node
  SOURCE_FILES AbstractionLayer.cpp
               ApplicationLevel.cpp
               FileInfoListener.cpp
               main.cpp
  HEADER_FILES AbstractionLayer.h
               ApplicationLevel.h
               FileInfoListener.h
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/DistributedContent
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_DistributedContent_Node
  IDL_FILES FileInfo.idl
)
#####################################
link_test_files_to_build_tree()