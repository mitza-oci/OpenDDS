project(Reliability CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(IDL)
add_subdirectory(sub)
add_subdirectory(pub)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Reliability/run_test.pl"
  COMMAND run_test.pl
  REQUIRES OPENDDS_HAS_OWNERSHIP_PROFILE
)


dds_add_test("tests/DCPS/Reliability/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES OPENDDS_HAS_OWNERSHIP_PROFILE
)


dds_add_test("tests/DCPS/Reliability/run_test.pl keep-last-one"
  COMMAND run_test.pl keep-last-one
)


dds_add_test("tests/DCPS/Reliability/run_test.pl rtps keep-last-one"
  COMMAND run_test.pl rtps keep-last-one
)
