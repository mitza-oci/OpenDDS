project(qos_dump CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(qos_dump
  OUTPUT_NAME qos_dump
  FOLDER tests/DCPS/QoS_XML/dump
  ASPECTS TAO
  LINK_LIBRARIES OpenDDS_QOS_XML_XSC_Handler
)
target_cxx_sources(qos_dump
  SOURCE_FILES qos_dump.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/QoS_XML/dump/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS4CCM_OPENDDS DCPS_MIN
)
