requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(Federation_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher_main.cpp
               Publisher.cpp
               TestConfig.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES Publisher.h
               TestConfig.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/Federation
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DcpsFooType5
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(Federation_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber_main.cpp
               Subscriber.cpp
               TestConfig.cpp
               DataReaderListener.cpp
  HEADER_FILES Subscriber.h
               TestConfig.h
               DataReaderListener.h
  FOLDER tests/DCPS/Federation
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DcpsFooType5
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Federation/run_test.pl"
  COMMAND run_test.pl
)
