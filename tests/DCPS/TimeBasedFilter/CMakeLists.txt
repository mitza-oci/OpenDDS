ace_requires(OWNERSHIP_PROFILE)

ace_add_exe(TimeBasedFilter
  OUTPUT_NAME tester
  FOLDER tests/DCPS/TimeBasedFilter
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
ace_target_cxx_sources(TimeBasedFilter
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/TimeBasedFilter/run_test.pl"
  COMMAND run_test.pl
)
