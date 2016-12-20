project(MultiDiscoveryTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(MultiDiscoveryTest
  OUTPUT_NAME MultiDiscoveryTest
  SOURCE_FILES DataReaderListenerImpl.cpp
               MultiDiscoveryTest.cpp
  HEADER_FILES DataReaderListenerImpl.h
  FOLDER tests/DCPS/MultiDiscovery
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
add_dds_idl_files(
  TARGETS MultiDiscoveryTest
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/MultiDiscovery/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST HOST
)
