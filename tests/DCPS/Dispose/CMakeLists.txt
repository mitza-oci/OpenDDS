requires(OWNERSHIP_PROFILE)

add_ace_exe(Dispose
  OUTPUT_NAME tester
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/Dispose
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/Dispose/run_test.pl"
  COMMAND run_test.pl
)
