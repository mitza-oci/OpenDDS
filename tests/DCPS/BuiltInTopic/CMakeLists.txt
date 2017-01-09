requires(BUILT_IN_TOPICS NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(BuiltInTopic
  OUTPUT_NAME bit
  FOLDER tests/DCPS/BuiltInTopic
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 OpenDDS_Dcps
)
target_cxx_sources(BuiltInTopic
  SOURCE_FILES common.cpp
               main.cpp
  HEADER_FILES common.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
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
