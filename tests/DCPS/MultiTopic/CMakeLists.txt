project(MultiTopicTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(MULTI_TOPIC CONTENT_SUBSCRIPTION)

ace_add_exe(MultiTopicTest
  OUTPUT_NAME MultiTopicTest
  FOLDER tests/DCPS/MultiTopic
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
)
ace_target_cxx_sources(MultiTopicTest
  SOURCE_FILES MultiTopicTest.cpp
)

dds_idl_sources(
  TARGETS MultiTopicTest
  IDL_FILES MultiTopicTest.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MultiTopic/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/MultiTopic/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES BUILD_SHARED_LIBS
  LABELS RTPS
)
