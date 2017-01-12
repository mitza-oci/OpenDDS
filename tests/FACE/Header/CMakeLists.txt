project(Header CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Idl)
add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Header/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
