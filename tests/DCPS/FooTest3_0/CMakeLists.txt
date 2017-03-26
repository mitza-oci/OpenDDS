ace_requires(OPENDDS_HAS_OBJECT_MODEL_PROFILE)

ace_add_exe(FooTest3_0_Publisher
  OUTPUT_NAME FooTest3_publisher
  FOLDER tests/DCPS/FooTest3_0
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType3
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(FooTest3_0_Publisher
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


ace_add_exe(FooTest3_0_Subscriber
  OUTPUT_NAME FooTest3_subscriber
  FOLDER tests/DCPS/FooTest3_0
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType3
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(FooTest3_0_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               SubDriver.cpp
               sub_main.cpp
  HEADER_FILES DataReaderListener.h
               SubDriver.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FooTest3_0/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)


dds_add_test("tests/DCPS/FooTest3_0/run_test.pl unregister"
  COMMAND run_test.pl unregister
)


dds_add_test("tests/DCPS/FooTest3_0/run_test.pl dispose"
  COMMAND run_test.pl dispose
)


dds_add_test("tests/DCPS/FooTest3_0/run_test.pl resume"
  COMMAND run_test.pl resume
)


dds_add_test("tests/DCPS/FooTest3_0/run_test.pl listener"
  COMMAND run_test.pl listener
)


dds_add_test("tests/DCPS/FooTest3_0/run_test.pl allocator"
  COMMAND run_test.pl allocator
)


dds_add_test("tests/DCPS/FooTest3_0/run_test.pl liveliness"
  COMMAND run_test.pl liveliness
)
