
project(namespace_conflict CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(DDS_namespace_conflict
  OUTPUT_NAME DDS_namespace_conflict
  FOLDER tests/DCPS/Compiler/namespace_conflict
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_namespace_conflict
  SOURCE_FILES main.cpp
)

dds_idl_sources(
  TARGETS DDS_namespace_conflict
  TAO_IDL_FLAGS -SS
  IDL_FILES Nsc.idl
)

