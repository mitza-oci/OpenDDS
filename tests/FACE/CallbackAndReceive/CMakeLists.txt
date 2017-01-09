add_subdirectory(Publisher)
add_subdirectory(Subscriber)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/CallbackAndReceive/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
