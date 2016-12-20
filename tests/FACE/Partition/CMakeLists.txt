project(Partition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Idl)
add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/FACE/Partition/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
