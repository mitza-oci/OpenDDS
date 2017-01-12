ace_requires(OWNERSHIP_PROFILE)

ace_add_exe(LivelinessTestPublisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/LivelinessTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
ace_target_cxx_sources(LivelinessTestPublisher
  SOURCE_FILES Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


ace_add_exe(LivelinessTestSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/LivelinessTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
ace_target_cxx_sources(LivelinessTestSubscriber
  SOURCE_FILES DataReaderListener.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/LivelinessTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/LivelinessTest/run_test.pl take"
  COMMAND run_test.pl take
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/LivelinessTest/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/LivelinessTest/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS RTPS
)


dds_add_test("tests/DCPS/LivelinessTest/run_test.pl rtps_disc take"
  COMMAND run_test.pl rtps_disc take
  LABELS RTPS
)
