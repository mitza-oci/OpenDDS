project(RtpsMessages CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(RtpsMessages
  OUTPUT_NAME RtpsMessagesTest
  FOLDER tests/DCPS/RtpsMessages
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Rtps
)
target_cxx_sources(RtpsMessages
  SOURCE_FILES RtpsMessagesTest.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/RtpsMessages/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
