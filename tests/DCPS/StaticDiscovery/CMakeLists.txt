project(StaticDiscoveryTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(StaticDiscoveryTest
  OUTPUT_NAME StaticDiscoveryTest
  FOLDER tests/DCPS/StaticDiscovery
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(StaticDiscoveryTest
  SOURCE_FILES DataReaderListenerImpl.cpp
               StaticDiscoveryTest.cpp
  HEADER_FILES DataReaderListenerImpl.h
)

dds_idl_sources(
  TARGETS StaticDiscoveryTest
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/StaticDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST
)


dds_add_test("tests/DCPS/StaticDiscovery/run_test.pl mp"
  COMMAND run_test.pl mp
  LABELS MCAST
)


dds_add_test("tests/DCPS/StaticDiscovery/run_test.pl mp delay"
  COMMAND run_test.pl mp delay
  LABELS MCAST
)


dds_add_test("tests/DCPS/StaticDiscovery/run_test.pl mr"
  COMMAND run_test.pl mr
  LABELS MCAST
)


dds_add_test("tests/DCPS/StaticDiscovery/run_test.pl mw"
  COMMAND run_test.pl mw
  LABELS MCAST
)


dds_add_test("tests/DCPS/StaticDiscovery/run_test.pl mpmrmw"
  COMMAND run_test.pl mpmrmw
  LABELS MCAST HOST
)
