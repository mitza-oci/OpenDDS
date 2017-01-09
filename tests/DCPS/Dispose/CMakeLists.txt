requires(OWNERSHIP_PROFILE)

add_ace_exe(Dispose
  OUTPUT_NAME tester
  FOLDER tests/DCPS/Dispose
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
target_cxx_sources(Dispose
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Dispose/run_test.pl"
  COMMAND run_test.pl
)
