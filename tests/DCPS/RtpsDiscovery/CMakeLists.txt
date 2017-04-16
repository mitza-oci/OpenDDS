project(RtpsDiscovery CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_BUILT_IN_TOPICS)

ace_add_exe(RtpsDiscovery
  OUTPUT_NAME RtpsDiscoveryTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(RtpsDiscovery
  SOURCE_FILES RtpsDiscoveryTest.cpp
)

dds_idl_sources(
  TARGETS RtpsDiscovery
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/RtpsDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST RTPS
)
