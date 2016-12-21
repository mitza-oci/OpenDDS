requires(BUILT_IN_TOPICS NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(BuiltInTopic
  OUTPUT_NAME bit
  SOURCE_FILES main.cpp
               common.cpp
  HEADER_FILES common.h
  FOLDER tests/DCPS/BuiltInTopic
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/BuiltInTopic/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_part"
  COMMAND run_test.pl ignore_part
)


add_dds_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_topic"
  COMMAND run_test.pl ignore_topic
)


add_dds_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_pub"
  COMMAND run_test.pl ignore_pub
)


add_dds_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_sub"
  COMMAND run_test.pl ignore_sub
)
