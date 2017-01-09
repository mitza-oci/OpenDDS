requires(OWNERSHIP_PROFILE BUILD_SHARED_LIBS)

add_ace_exe(DcpsFooTest5_0
  OUTPUT_NAME main
  FOLDER tests/DCPS/FooTest5_0
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES DcpsFooType4
                 OpenDDS_Dcps
)
target_cxx_sources(DcpsFooTest5_0
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/FooTest5_0/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/FooTest5_0/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/FooTest5_0/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)


add_dds_test("tests/DCPS/FooTest5_0/run_test.pl shmem"
  COMMAND run_test.pl shmem
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


add_dds_test("tests/DCPS/FooTest5_0/run_test.pl diff_trans"
  COMMAND run_test.pl diff_trans
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)
