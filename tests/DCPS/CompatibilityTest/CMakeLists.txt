add_ace_exe(CompatibilityTest_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/CompatibilityTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(CompatibilityTest_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
               common.h
)


add_ace_exe(CompatibilityTest_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/CompatibilityTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(CompatibilityTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/CompatibilityTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/CompatibilityTest/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS RTPS
)


add_dds_test("tests/DCPS/CompatibilityTest/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)
