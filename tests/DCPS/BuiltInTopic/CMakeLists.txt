ace_requires(BUILT_IN_TOPICS NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(BuiltInTopic
  OUTPUT_NAME bit
  FOLDER tests/DCPS/BuiltInTopic
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(BuiltInTopic
  SOURCE_FILES common.cpp
               main.cpp
  HEADER_FILES common.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/BuiltInTopic/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_part"
  COMMAND run_test.pl ignore_part
)


dds_add_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_topic"
  COMMAND run_test.pl ignore_topic
)


dds_add_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_pub"
  COMMAND run_test.pl ignore_pub
)


dds_add_test("tests/DCPS/BuiltInTopic/run_test.pl ignore_sub"
  COMMAND run_test.pl ignore_sub
)
