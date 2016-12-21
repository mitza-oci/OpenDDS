project(MultiTopicTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(MULTI_TOPIC CONTENT_SUBSCRIPTION)

add_ace_exe(MultiTopicTest
  OUTPUT_NAME MultiTopicTest
  SOURCE_FILES MultiTopicTest.cpp
  FOLDER tests/DCPS/MultiTopic
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)
dds_idl_sources(
  TARGETS MultiTopicTest
  IDL_FILES MultiTopicTest.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/MultiTopic/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/MultiTopic/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES BUILD_SHARED_LIBS
  LABELS RTPS
)
