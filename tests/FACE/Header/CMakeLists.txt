project(Header CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Idl)
add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Header/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
