ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE BUILD_SHARED_LIBS)

ace_add_exe(DcpsFooTest5_0
  OUTPUT_NAME main
  FOLDER tests/DCPS/FooTest5_0
  LINK_LIBRARIES DcpsFooType4
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DcpsFooTest5_0
  SOURCE_FILES main.cpp
)
ace_target_cxx_sources(DcpsFooTest5_0
  SOURCE_FILES main.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FooTest5_0/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS DCPS_MIN
)


dds_add_test("tests/DCPS/FooTest5_0/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5_0/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)


dds_add_test("tests/DCPS/FooTest5_0/run_test.pl shmem"
  COMMAND run_test.pl shmem
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS SHMEM
)


dds_add_test("tests/DCPS/FooTest5_0/run_test.pl diff_trans"
  COMMAND run_test.pl diff_trans
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)
