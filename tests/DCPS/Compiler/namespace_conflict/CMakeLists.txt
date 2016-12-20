
project(namespace_conflict CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(DDS_namespace_conflict
  OUTPUT_NAME DDS_namespace_conflict
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/Compiler/namespace_conflict
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_namespace_conflict
  TAO_IDL_FLAGS -SS
  IDL_FILES Nsc.idl
)
