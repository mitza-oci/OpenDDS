project(Reliability CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(IDL)
add_subdirectory(sub)
add_subdirectory(pub)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Reliability/run_test.pl"
  COMMAND run_test.pl
  REQUIRES OWNERSHIP_PROFILE
)


add_dds_test("tests/DCPS/Reliability/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES OWNERSHIP_PROFILE
)


add_dds_test("tests/DCPS/Reliability/run_test.pl keep-last-one"
  COMMAND run_test.pl keep-last-one
)


add_dds_test("tests/DCPS/Reliability/run_test.pl rtps keep-last-one"
  COMMAND run_test.pl rtps keep-last-one
)
