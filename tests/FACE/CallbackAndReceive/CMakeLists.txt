add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/CallbackAndReceive/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
  RESOURCE_LOCK FACE
)
