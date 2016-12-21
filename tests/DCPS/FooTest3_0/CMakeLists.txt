requires(OBJECT_MODEL_PROFILE)

add_ace_exe(FooTest3_0_Publisher
  OUTPUT_NAME FooTest3_publisher
  SOURCE_FILES pub_main.cpp
               PubDriver.cpp
               DataWriterListener.cpp
               DomainParticipantListener.cpp
               PublisherListener.cpp
  HEADER_FILES PubDriver.h
               DataWriterListener.h
               DomainParticipantListener.h
               PublisherListener.h
  FOLDER tests/DCPS/FooTest3_0
  LINK_LIBRARIES DcpsFooType3
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(FooTest3_0_Subscriber
  OUTPUT_NAME FooTest3_subscriber
  SOURCE_FILES sub_main.cpp
               SubDriver.cpp
               DataReaderListener.cpp
  HEADER_FILES SubDriver.h
               DataReaderListener.h
  FOLDER tests/DCPS/FooTest3_0
  LINK_LIBRARIES DcpsFooType3
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
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
