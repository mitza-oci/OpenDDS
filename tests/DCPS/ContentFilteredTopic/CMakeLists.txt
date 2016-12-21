project(ContentFilteredTopic CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(CONTENT_FILTERED_TOPIC CONTENT_SUBSCRIPTION)

add_ace_exe(ContentFilteredTopic
  OUTPUT_NAME ContentFilteredTopicTest
  SOURCE_FILES ContentFilteredTopicTest.cpp
  FOLDER tests/DCPS/ContentFilteredTopic
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)
dds_idl_sources(
  TARGETS ContentFilteredTopic
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ContentFilteredTopic/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ContentFilteredTopic/run_test.pl nopub"
  COMMAND run_test.pl nopub
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ContentFilteredTopic/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)


add_dds_test("tests/DCPS/ContentFilteredTopic/run_test.pl rtps_disc nopub"
  COMMAND run_test.pl rtps_disc nopub
  LABELS MCAST RTPS
)
