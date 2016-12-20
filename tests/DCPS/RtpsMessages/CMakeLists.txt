project(RtpsMessages CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(RtpsMessages
  OUTPUT_NAME RtpsMessagesTest
  SOURCE_FILES RtpsMessagesTest.cpp
  FOLDER tests/DCPS/RtpsMessages
  LINK_LIBRARIES OpenDDS_Rtps
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/RtpsMessages/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
