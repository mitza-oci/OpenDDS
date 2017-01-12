project(MultiDiscoveryTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(MultiDiscoveryTest
  OUTPUT_NAME MultiDiscoveryTest
  FOLDER tests/DCPS/MultiDiscovery
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(MultiDiscoveryTest
  SOURCE_FILES DataReaderListenerImpl.cpp
               MultiDiscoveryTest.cpp
  HEADER_FILES DataReaderListenerImpl.h
)

dds_idl_sources(
  TARGETS MultiDiscoveryTest
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MultiDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST HOST
)
