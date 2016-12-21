project(Header CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Idl)
add_subdirectory(Publisher)
add_subdirectory(Subscriber)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Header/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
