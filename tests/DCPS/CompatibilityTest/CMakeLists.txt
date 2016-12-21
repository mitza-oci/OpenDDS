add_ace_exe(CompatibilityTest_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES common.cpp
               publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES common.h
               Writer.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/CompatibilityTest
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(CompatibilityTest_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES common.cpp
               subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES common.h
               DataReaderListener.h
  FOLDER tests/DCPS/CompatibilityTest
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
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
