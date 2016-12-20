requires(CONTENT_FILTERED_TOPIC CONTENT_SUBSCRIPTION)

add_ace_exe(SubscriberCycle_publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
               ParticipantTask.cpp
               ProgressIndicator.cpp
  HEADER_FILES ParticipantTask.h
               ProgressIndicator.h
  FOLDER tests/DCPS/SubscriberCycle
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(SubscriberCycle_subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               SubscriberListenerImpl.cpp
               ProgressIndicator.cpp
  HEADER_FILES SubscriberListenerImpl.h
               ProgressIndicator.h
  FOLDER tests/DCPS/SubscriberCycle
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/SubscriberCycle/run_test.pl"
  COMMAND run_test.pl
)
