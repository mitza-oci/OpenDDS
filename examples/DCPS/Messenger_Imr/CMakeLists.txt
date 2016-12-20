project(Messenger_Imr CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("examples/DCPS/Messenger_Imr/run_test.pl"
  COMMAND run_test.pl
)
