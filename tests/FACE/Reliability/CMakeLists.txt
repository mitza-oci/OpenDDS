add_subdirectory(Publisher)
add_subdirectory(Subscriber)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Reliability/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
  RESOURCE_LOCK FACE_Messenger
)
