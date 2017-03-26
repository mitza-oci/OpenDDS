add_subdirectory(Idl)
add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Messenger/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS FACE
  RESOURCE_LOCK RTPS_FACE
)


dds_add_test("tests/FACE/Messenger/run_test.pl callback"
  COMMAND run_test.pl callback
  LABELS RTPS FACE
  RESOURCE_LOCK RTPS_FACE
)


dds_add_test("tests/FACE/Messenger/run_test.pl static"
  COMMAND run_test.pl static
  LABELS RTPS FACE
  RESOURCE_LOCK RTPS_FACE
)


dds_add_test("tests/FACE/Messenger/run_test.pl static callback"
  COMMAND run_test.pl static callback
  LABELS RTPS FACE
  RESOURCE_LOCK RTPS_FACE
)
