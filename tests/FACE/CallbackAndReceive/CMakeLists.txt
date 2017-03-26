add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/CallbackAndReceive/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS FACE
  RESOURCE_LOCK RTPS_FACE
)
