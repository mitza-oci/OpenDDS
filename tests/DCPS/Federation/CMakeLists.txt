ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE "NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(Federation_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Federation
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Federation_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Publisher.cpp
               TestConfig.cpp
               publisher_main.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Publisher.h
               TestConfig.h
)


ace_add_exe(Federation_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Federation
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Federation_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               Subscriber.cpp
               TestConfig.cpp
               subscriber_main.cpp
  HEADER_FILES DataReaderListener.h
               Subscriber.h
               TestConfig.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Federation/run_test.pl"
  COMMAND run_test.pl
)
