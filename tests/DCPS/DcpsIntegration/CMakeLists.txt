add_ace_exe(dcps_integration_topic
  OUTPUT_NAME topic_test
  SOURCE_FILES topic.cpp
               DomainParticipantListener.cpp
               TopicListener.cpp
  HEADER_FILES DomainParticipantListener.h
               TopicListener.h
  FOLDER tests/DCPS/DcpsIntegration
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(dcps_integration_infrastructure
  OUTPUT_NAME infrastructure_test
  SOURCE_FILES infrastructure.cpp
               DomainParticipantListener.cpp
  HEADER_FILES DomainParticipantListener.h
  FOLDER tests/DCPS/DcpsIntegration
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
