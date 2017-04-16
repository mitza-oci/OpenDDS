ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(SharedTransport
  OUTPUT_NAME tester
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 TestFramework
)
ace_target_cxx_sources(SharedTransport
  SOURCE_FILES TestCase.cpp
  HEADER_FILES TestCase.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/SharedTransport/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/SharedTransport/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)


dds_add_test("tests/DCPS/SharedTransport/run_test.pl rtps 2"
  COMMAND run_test.pl rtps 2
  LABELS RTPS
)


dds_add_test("tests/DCPS/SharedTransport/run_test.pl udp"
  COMMAND run_test.pl udp
)


dds_add_test("tests/DCPS/SharedTransport/run_test.pl multicast"
  COMMAND run_test.pl multicast
  LABELS MCAST
)


dds_add_test("tests/DCPS/SharedTransport/run_test.pl shmem"
  COMMAND run_test.pl shmem
  LABELS SHMEM
)


dds_add_test("tests/DCPS/SharedTransport/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  LABELS MCAST RTPS
)
