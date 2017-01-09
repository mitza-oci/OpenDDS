requires(OWNERSHIP_PROFILE)

add_ace_exe(DestinationOrder
  OUTPUT_NAME tester
  FOLDER tests/DCPS/DestinationOrder
  ASPECTS DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES TestFramework
                 OpenDDS_Dcps
)
target_cxx_sources(DestinationOrder
  SOURCE_FILES TestCase.cpp
  HEADER_FILES TestCase.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/DestinationOrder/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/DestinationOrder/run_test.pl source"
  COMMAND run_test.pl source
)
