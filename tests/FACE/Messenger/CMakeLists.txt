add_subdirectory(Idl)
add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Messenger/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
  RESOURCE_LOCK FACE_Messenger
)


dds_add_test("tests/FACE/Messenger/run_test.pl callback"
  COMMAND run_test.pl callback
  LABELS RTPS
  RESOURCE_LOCK FACE_Messenger
)


dds_add_test("tests/FACE/Messenger/run_test.pl static"
  COMMAND run_test.pl static
  LABELS RTPS
  RESOURCE_LOCK FACE_Messenger
)


dds_add_test("tests/FACE/Messenger/run_test.pl static callback"
  COMMAND run_test.pl static callback
  LABELS RTPS
  RESOURCE_LOCK FACE_Messenger
)
