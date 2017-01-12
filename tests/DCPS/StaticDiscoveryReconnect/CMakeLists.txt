project(StaticDiscoveryReconnectTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(StaticDiscoveryReconnectTest
  OUTPUT_NAME StaticDiscoveryReconnectTest
  FOLDER tests/DCPS/StaticDiscoveryReconnect
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(StaticDiscoveryReconnectTest
  SOURCE_FILES StaticDiscoveryTest.cpp
)

dds_idl_sources(
  TARGETS StaticDiscoveryReconnectTest
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/StaticDiscoveryReconnect/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST
)
