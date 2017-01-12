project(qos_dump CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(qos_dump
  OUTPUT_NAME qos_dump
  FOLDER tests/DCPS/QoS_XML/dump
  ASPECTS TAO
  LINK_LIBRARIES OpenDDS_QOS_XML_XSC_Handler
)
ace_target_cxx_sources(qos_dump
  SOURCE_FILES qos_dump.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/QoS_XML/dump/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS4CCM_OPENDDS DCPS_MIN
)
