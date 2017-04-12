project(MultiDomainMessenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

ace_requires("TARGET OpenDDS_FACE")

add_subdirectory(Idl)
add_subdirectory(Publisher)
add_subdirectory(Subscriber)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/MultiDomainMessenger/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS FACE
)


dds_add_test("tests/FACE/MultiDomainMessenger/run_test.pl callback"
  COMMAND run_test.pl callback
  LABELS RTPS FACE
)
