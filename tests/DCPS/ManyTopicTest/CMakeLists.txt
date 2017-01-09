add_ace_exe(ManyTopicTestPublisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/ManyTopicTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
                 common
                 ManyTopicTypes
)
target_cxx_sources(ManyTopicTestPublisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


add_ace_exe(ManyTopicTestSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/ManyTopicTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES common
                 OpenDDS_Dcps
                 ManyTopicTypes
)
target_cxx_sources(ManyTopicTestSubscriber
  SOURCE_FILES subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ManyTopicTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyTopicTest/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)
