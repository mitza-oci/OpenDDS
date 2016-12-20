requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(SharedTransport
  OUTPUT_NAME tester
  SOURCE_FILES TestCase.cpp
  HEADER_FILES TestCase.h
  FOLDER tests/DCPS/SharedTransport
  LINK_LIBRARIES TestFramework
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/SharedTransport/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/SharedTransport/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)


add_dds_test("tests/DCPS/SharedTransport/run_test.pl rtps 2"
  COMMAND run_test.pl rtps 2
  LABELS RTPS
)


add_dds_test("tests/DCPS/SharedTransport/run_test.pl udp"
  COMMAND run_test.pl udp
)


add_dds_test("tests/DCPS/SharedTransport/run_test.pl multicast"
  COMMAND run_test.pl multicast
  LABELS MCAST
)


add_dds_test("tests/DCPS/SharedTransport/run_test.pl shmem"
  COMMAND run_test.pl shmem
  LABELS SHMEM
)


add_dds_test("tests/DCPS/SharedTransport/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  LABELS MCAST RTPS
)
