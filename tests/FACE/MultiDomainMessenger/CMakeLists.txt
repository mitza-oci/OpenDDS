project(MultiDomainMessenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(Idl)
add_subdirectory(Publisher)
add_subdirectory(Subscriber)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/MultiDomainMessenger/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
  RESOURCE_LOCK FACE
)


dds_add_test("tests/FACE/MultiDomainMessenger/run_test.pl callback"
  COMMAND run_test.pl callback
  LABELS RTPS
  RESOURCE_LOCK FACE
)
