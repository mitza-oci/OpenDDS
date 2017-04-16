ace_add_exe(CompatibilityTest_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(CompatibilityTest_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
               common.h
)


ace_add_exe(CompatibilityTest_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(CompatibilityTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/CompatibilityTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE" LONG_TEST
)


dds_add_test("tests/DCPS/CompatibilityTest/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc LONG_TEST
  LABELS RTPS
)


dds_add_test("tests/DCPS/CompatibilityTest/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE" LONG_TEST
  LABELS RTPS
)
