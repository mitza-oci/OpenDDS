project(StaticDiscoveryTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(StaticDiscoveryTest
  OUTPUT_NAME StaticDiscoveryTest
  FOLDER tests/DCPS/StaticDiscovery
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(StaticDiscoveryTest
  SOURCE_FILES DataReaderListenerImpl.cpp
               StaticDiscoveryTest.cpp
  HEADER_FILES DataReaderListenerImpl.h
)

dds_idl_sources(
  TARGETS StaticDiscoveryTest
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/StaticDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST
)


add_dds_test("tests/DCPS/StaticDiscovery/run_test.pl mp"
  COMMAND run_test.pl mp
  LABELS MCAST
)


add_dds_test("tests/DCPS/StaticDiscovery/run_test.pl mp delay"
  COMMAND run_test.pl mp delay
  LABELS MCAST
)


add_dds_test("tests/DCPS/StaticDiscovery/run_test.pl mr"
  COMMAND run_test.pl mr
  LABELS MCAST
)


add_dds_test("tests/DCPS/StaticDiscovery/run_test.pl mw"
  COMMAND run_test.pl mw
  LABELS MCAST
)


add_dds_test("tests/DCPS/StaticDiscovery/run_test.pl mpmrmw"
  COMMAND run_test.pl mpmrmw
  LABELS MCAST HOST
)
