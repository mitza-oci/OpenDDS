requires(OWNERSHIP_PROFILE)

add_ace_exe(ReaderDataLifecycle
  OUTPUT_NAME tester
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/ReaderDataLifecycle
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ReaderDataLifecycle/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ReaderDataLifecycle/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)
