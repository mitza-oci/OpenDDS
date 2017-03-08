project(StaticDiscoveryReconnectTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(StaticDiscoveryReconnectTest
  OUTPUT_NAME StaticDiscoveryTest
  FOLDER tests/DCPS/StaticDiscoveryReconnect
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(StaticDiscoveryReconnectTest
  SOURCE_FILES StaticDiscoveryTest.cpp
)

dds_idl_sources(
  TARGETS StaticDiscoveryReconnectTest
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/StaticDiscoveryReconnect/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST
)
