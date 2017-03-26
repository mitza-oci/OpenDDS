ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_exe(DestinationOrder
  OUTPUT_NAME tester
  FOLDER tests/DCPS/DestinationOrder
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 TestFramework
)
ace_target_cxx_sources(DestinationOrder
  SOURCE_FILES TestCase.cpp
  HEADER_FILES TestCase.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/DestinationOrder/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/DestinationOrder/run_test.pl source"
  COMMAND run_test.pl source
)
