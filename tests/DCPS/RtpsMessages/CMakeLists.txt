project(RtpsMessages CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(RtpsMessages
  OUTPUT_NAME RtpsMessagesTest
  LINK_LIBRARIES OpenDDS_Rtps
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(RtpsMessages
  SOURCE_FILES RtpsMessagesTest.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/RtpsMessages/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
