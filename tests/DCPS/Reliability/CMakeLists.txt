project(Reliability CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(IDL)
add_subdirectory(pub)
add_subdirectory(sub)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
