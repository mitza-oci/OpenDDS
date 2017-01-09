project(RtpsDiscovery CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(BUILT_IN_TOPICS)

add_ace_exe(RtpsDiscovery
  OUTPUT_NAME RtpsDiscoveryTest
  FOLDER tests/DCPS/RtpsDiscovery
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
)
target_cxx_sources(RtpsDiscovery
  SOURCE_FILES RtpsDiscoveryTest.cpp
)

dds_idl_sources(
  TARGETS RtpsDiscovery
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/RtpsDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST RTPS
)
