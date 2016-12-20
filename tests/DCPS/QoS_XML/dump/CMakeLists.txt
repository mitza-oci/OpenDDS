project(qos_dump CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OpenDDS_QOS_XML_XSC_Handler TARGET)

add_ace_exe(qos_dump
  OUTPUT_NAME qos_dump
  SOURCE_FILES qos_dump.cpp
  FOLDER tests/DCPS/QoS_XML/dump
  LINK_LIBRARIES OpenDDS_QOS_XML_XSC_Handler
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/QoS_XML/dump/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS4CCM_OPENDDS DCPS_MIN
)
