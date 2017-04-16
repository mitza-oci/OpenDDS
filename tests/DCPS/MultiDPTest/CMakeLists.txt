ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_exe(MultiDPTest_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(MultiDPTest_Publisher
  SOURCE_FILES Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


ace_add_exe(MultiDPTest_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(MultiDPTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MultiDPTest/run_test.pl"
  COMMAND run_test.pl
)
