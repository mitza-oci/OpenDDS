project(RtpsDiscovery CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(BUILT_IN_TOPICS)

add_ace_exe(RtpsDiscovery
  OUTPUT_NAME RtpsDiscoveryTest
  SOURCE_FILES RtpsDiscoveryTest.cpp
  FOLDER tests/DCPS/RtpsDiscovery
  LINK_LIBRARIES OpenDDS_Model
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
add_dds_idl_files(
  TARGETS RtpsDiscovery
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/RtpsDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST RTPS
)
