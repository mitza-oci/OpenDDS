project(MultiTopicTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_MULTI_TOPIC OPENDDS_HAS_CONTENT_SUBSCRIPTION)

ace_add_exe(MultiTopicTest
  OUTPUT_NAME MultiTopicTest

  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(MultiTopicTest
  SOURCE_FILES MultiTopicTest.cpp
)

dds_idl_sources(
  TARGETS MultiTopicTest
  IDL_FILES MultiTopicTest.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MultiTopic/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/MultiTopic/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES BUILD_SHARED_LIBS
  LABELS RTPS
)
