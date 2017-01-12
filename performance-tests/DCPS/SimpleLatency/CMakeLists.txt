
project(SimpleLatency CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(SimpleLatency_Idl
  OUTPUT_NAME SimpleLatency_Idl
  FOLDER performance-tests/DCPS/SimpleLatency
  DEFINE_SYMBOL SIMPLELATENCY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS SimpleLatency_Idl
  DDS_IDL_FLAGS -Wb,export_macro=SimpleLatency_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SimpleLatency_export.h
                -Wb,stub_export_macro=SimpleLatency_Export
                -SS
  IDL_FILES DDSPerfTest.idl
)


ace_add_exe(DDS_SimpleLatency_Pub
  OUTPUT_NAME dds_pub
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER performance-tests/DCPS/SimpleLatency
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES SimpleLatency_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_SimpleLatency_Pub
  SOURCE_FILES PubListener.cpp
               sample_pub.cpp
  HEADER_FILES PubListener.h
)


ace_add_exe(DDS_SimpleLatency_Sub
  OUTPUT_NAME dds_sub
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER performance-tests/DCPS/SimpleLatency
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES SimpleLatency_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_SimpleLatency_Sub
  SOURCE_FILES SubListener.cpp
               sample_sub.cpp
  HEADER_FILES SubListener.h
)

add_subdirectory(raw_tcp)
