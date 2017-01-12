ace_requires(CONTENT_FILTERED_TOPIC CONTENT_SUBSCRIPTION)

ace_add_exe(SubscriberCycle_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/SubscriberCycle
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
ace_target_cxx_sources(SubscriberCycle_Publisher
  SOURCE_FILES ParticipantTask.cpp
               ProgressIndicator.cpp
               Publisher.cpp
  HEADER_FILES ParticipantTask.h
               ProgressIndicator.h
)


ace_add_exe(SubscriberCycle_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/SubscriberCycle
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
ace_target_cxx_sources(SubscriberCycle_Subscriber
  SOURCE_FILES ProgressIndicator.cpp
               Subscriber.cpp
               SubscriberListenerImpl.cpp
  HEADER_FILES ProgressIndicator.h
               SubscriberListenerImpl.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/SubscriberCycle/run_test.pl"
  COMMAND run_test.pl
)
