
project(SimpleLatency CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(SimpleLatency_idl
  OUTPUT_NAME SimpleLatency_idl
  FOLDER performance-tests/DCPS/SimpleLatency
  DEFINE_SYMBOL SIMPLELATENCY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS SimpleLatency_idl
  DDS_IDL_FLAGS -Wb,export_macro=SimpleLatency_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SimpleLatency_export.h
                -Wb,stub_export_macro=SimpleLatency_Export
                -SS
  IDL_FILES DDSPerfTest.idl
)

add_ace_exe(DDS_SimpleLatency_Pub
  OUTPUT_NAME dds_pub
  SOURCE_FILES sample_pub.cpp
               PubListener.cpp
  HEADER_FILES PubListener.h
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER performance-tests/DCPS/SimpleLatency
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 SimpleLatency_idl
                 OpenDDS_Dcps
)

add_ace_exe(DDS_SimpleLatency_Sub
  OUTPUT_NAME dds_sub
  SOURCE_FILES sample_sub.cpp
               SubListener.cpp
  HEADER_FILES SubListener.h
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER performance-tests/DCPS/SimpleLatency
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 SimpleLatency_idl
                 OpenDDS_Dcps
)
add_subdirectory(raw_tcp)
