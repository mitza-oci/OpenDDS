ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_exe(TimeBasedFilter
  OUTPUT_NAME tester
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(TimeBasedFilter
  SOURCE_FILES main.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/TimeBasedFilter/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/TimeBasedFilter/run_test.pl -r"
  COMMAND run_test.pl -r
)
