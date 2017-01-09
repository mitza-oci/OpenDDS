requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(Federation_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Federation
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType5
                 OpenDDS_Dcps
)
target_cxx_sources(Federation_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Publisher.cpp
               TestConfig.cpp
               publisher_main.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Publisher.h
               TestConfig.h
)


add_ace_exe(Federation_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Federation
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType5
                 OpenDDS_Dcps
)
target_cxx_sources(Federation_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               Subscriber.cpp
               TestConfig.cpp
               subscriber_main.cpp
  HEADER_FILES DataReaderListener.h
               Subscriber.h
               TestConfig.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Federation/run_test.pl"
  COMMAND run_test.pl
)
