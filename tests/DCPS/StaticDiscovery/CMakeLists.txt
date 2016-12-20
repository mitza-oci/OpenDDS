project(StaticDiscoveryTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(StaticDiscoveryTest
  OUTPUT_NAME StaticDiscoveryTest
  SOURCE_FILES DataReaderListenerImpl.cpp
               StaticDiscoveryTest.cpp
  HEADER_FILES DataReaderListenerImpl.h
  FOLDER tests/DCPS/StaticDiscovery
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
add_dds_idl_files(
  TARGETS StaticDiscoveryTest
  TAO_IDL_FLAGS -SS
  IDL_FILES TestMsg.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
