requires(OWNERSHIP_PROFILE)

add_ace_exe(DestinationOrder
  OUTPUT_NAME tester
  SOURCE_FILES TestCase.cpp
  HEADER_FILES TestCase.h
  FOLDER tests/DCPS/DestinationOrder
  LINK_LIBRARIES TestFramework
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/DestinationOrder/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/DestinationOrder/run_test.pl source"
  COMMAND run_test.pl source
)
