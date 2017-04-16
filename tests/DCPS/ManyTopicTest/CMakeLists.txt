ace_add_exe(ManyTopicTestPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 ManyTopicTypes
                 common
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ManyTopicTestPublisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


ace_add_exe(ManyTopicTestSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 ManyTopicTypes
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ManyTopicTestSubscriber
  SOURCE_FILES subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ManyTopicTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyTopicTest/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)
