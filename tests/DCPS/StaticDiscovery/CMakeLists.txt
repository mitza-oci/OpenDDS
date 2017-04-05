project(StaticDiscoveryTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(StaticDiscoveryTest
  OUTPUT_NAME StaticDiscoveryTest

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
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

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
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
