add_ace_exe(ManyTopicTestPublisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES common.h
               Writer.h
  FOLDER tests/DCPS/ManyTopicTest
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ManyTopicTypes
                 ${DCPS_TRANSPORTS_FOR_TEST}
                 common
                 OpenDDS_Model
)

add_ace_exe(ManyTopicTestSubscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
  HEADER_FILES common.h
               DataReaderListener.h
  FOLDER tests/DCPS/ManyTopicTest
  LINK_LIBRARIES ManyTopicTypes
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/ManyTopicTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyTopicTest/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)
