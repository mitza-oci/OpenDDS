add_subdirectory(Idl)
add_subdirectory(Publisher)
add_subdirectory(Subscriber)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Messenger/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)


add_dds_test("tests/FACE/Messenger/run_test.pl callback"
  COMMAND run_test.pl callback
  LABELS RTPS
)


add_dds_test("tests/FACE/Messenger/run_test.pl static"
  COMMAND run_test.pl static
  LABELS RTPS
)


add_dds_test("tests/FACE/Messenger/run_test.pl static callback"
  COMMAND run_test.pl static callback
  LABELS RTPS
)
