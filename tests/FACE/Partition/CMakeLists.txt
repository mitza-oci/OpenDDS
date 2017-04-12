project(Partition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

ace_requires(OPENDDS_HAS_BUILT_IN_TOPICS)

add_subdirectory(Idl)
add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Partition/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS FACE
)
