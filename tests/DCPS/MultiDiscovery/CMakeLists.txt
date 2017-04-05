project(MultiDiscoveryTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(MultiDiscoveryTest
  OUTPUT_NAME MultiDiscoveryTest

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
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

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MultiDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST HOST
)
