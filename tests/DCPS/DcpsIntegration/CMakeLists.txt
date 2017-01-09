add_ace_exe(dcps_integration_Topic
  OUTPUT_NAME topic_test
  FOLDER tests/DCPS/DcpsIntegration
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
target_cxx_sources(dcps_integration_Topic
  SOURCE_FILES DomainParticipantListener.cpp
               TopicListener.cpp
               topic.cpp
  HEADER_FILES DomainParticipantListener.h
               TopicListener.h
)


add_ace_exe(dcps_integration_Infrastructure
  OUTPUT_NAME infrastructure_test
  FOLDER tests/DCPS/DcpsIntegration
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
target_cxx_sources(dcps_integration_Infrastructure
  SOURCE_FILES DomainParticipantListener.cpp
               infrastructure.cpp
  HEADER_FILES DomainParticipantListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/DcpsIntegration/run_test-integration.pl"
  COMMAND run_test-integration.pl
)


add_dds_test("tests/DCPS/DcpsIntegration/run_test-topic.pl"
  COMMAND run_test-topic.pl
  REQUIRES PERSISTENCE_PROFILE
)


add_dds_test("tests/DCPS/DcpsIntegration/run_test-topic.pl rtps_disc"
  COMMAND run_test-topic.pl rtps_disc
  REQUIRES PERSISTENCE_PROFILE
  LABELS MCAST RTPS
)


add_dds_test("tests/DCPS/DcpsIntegration/run_test-topic.pl rtps_disc_tcp"
  COMMAND run_test-topic.pl rtps_disc_tcp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE PERSISTENCE_PROFILE
  LABELS MCAST RTPS
)
