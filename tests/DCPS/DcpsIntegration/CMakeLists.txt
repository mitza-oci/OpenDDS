ace_add_exe(dcps_integration_Topic
  OUTPUT_NAME topic_test
  FOLDER tests/DCPS/DcpsIntegration
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(dcps_integration_Topic
  SOURCE_FILES DomainParticipantListener.cpp
               TopicListener.cpp
               topic.cpp
  HEADER_FILES DomainParticipantListener.h
               TopicListener.h
)


ace_add_exe(dcps_integration_Infrastructure
  OUTPUT_NAME infrastructure_test
  FOLDER tests/DCPS/DcpsIntegration
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(dcps_integration_Infrastructure
  SOURCE_FILES DomainParticipantListener.cpp
               infrastructure.cpp
  HEADER_FILES DomainParticipantListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/DcpsIntegration/run_test-integration.pl"
  COMMAND run_test-integration.pl
)


dds_add_test("tests/DCPS/DcpsIntegration/run_test-topic.pl"
  COMMAND run_test-topic.pl
  REQUIRES PERSISTENCE_PROFILE
)


dds_add_test("tests/DCPS/DcpsIntegration/run_test-topic.pl rtps_disc"
  COMMAND run_test-topic.pl rtps_disc
  REQUIRES PERSISTENCE_PROFILE
  LABELS MCAST RTPS
)


dds_add_test("tests/DCPS/DcpsIntegration/run_test-topic.pl rtps_disc_tcp"
  COMMAND run_test-topic.pl rtps_disc_tcp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE PERSISTENCE_PROFILE
  LABELS MCAST RTPS
)
