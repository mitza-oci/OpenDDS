add_subdirectory(Idl)
add_subdirectory(Subscriber)
add_subdirectory(Publisher)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
