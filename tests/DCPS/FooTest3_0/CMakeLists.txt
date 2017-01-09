requires(OBJECT_MODEL_PROFILE)

add_ace_exe(FooTest3_0_Publisher
  OUTPUT_NAME FooTest3_publisher
  FOLDER tests/DCPS/FooTest3_0
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType3
                 OpenDDS_Dcps
)
target_cxx_sources(FooTest3_0_Publisher
  SOURCE_FILES DataWriterListener.cpp
               DomainParticipantListener.cpp
               PubDriver.cpp
               PublisherListener.cpp
               pub_main.cpp
  HEADER_FILES DataWriterListener.h
               DomainParticipantListener.h
               PubDriver.h
               PublisherListener.h
)


add_ace_exe(FooTest3_0_Subscriber
  OUTPUT_NAME FooTest3_subscriber
  FOLDER tests/DCPS/FooTest3_0
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType3
                 OpenDDS_Dcps
)
target_cxx_sources(FooTest3_0_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               SubDriver.cpp
               sub_main.cpp
  HEADER_FILES DataReaderListener.h
               SubDriver.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/FooTest3_0/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/FooTest3_0/run_test.pl unregister"
  COMMAND run_test.pl unregister
)


add_dds_test("tests/DCPS/FooTest3_0/run_test.pl dispose"
  COMMAND run_test.pl dispose
)


add_dds_test("tests/DCPS/FooTest3_0/run_test.pl resume"
  COMMAND run_test.pl resume
)


add_dds_test("tests/DCPS/FooTest3_0/run_test.pl listener"
  COMMAND run_test.pl listener
)


add_dds_test("tests/DCPS/FooTest3_0/run_test.pl allocator"
  COMMAND run_test.pl allocator
)


add_dds_test("tests/DCPS/FooTest3_0/run_test.pl liveliness"
  COMMAND run_test.pl liveliness
)
