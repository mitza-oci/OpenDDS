project(ContentFilteredTopic CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(CONTENT_FILTERED_TOPIC CONTENT_SUBSCRIPTION)

ace_add_exe(ContentFilteredTopic
  OUTPUT_NAME ContentFilteredTopicTest
  FOLDER tests/DCPS/ContentFilteredTopic
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(ContentFilteredTopic
  SOURCE_FILES ContentFilteredTopicTest.cpp
)

dds_idl_sources(
  TARGETS ContentFilteredTopic
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ContentFilteredTopic/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ContentFilteredTopic/run_test.pl nopub"
  COMMAND run_test.pl nopub
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ContentFilteredTopic/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)


dds_add_test("tests/DCPS/ContentFilteredTopic/run_test.pl rtps_disc nopub"
  COMMAND run_test.pl rtps_disc nopub
  LABELS MCAST RTPS
)
