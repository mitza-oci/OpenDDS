add_subdirectory(Publisher)
add_subdirectory(Subscriber)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/FACE/Reliability/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
