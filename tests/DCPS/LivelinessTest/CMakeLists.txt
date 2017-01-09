requires(OWNERSHIP_PROFILE)

add_ace_exe(LivelinessTestPublisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/LivelinessTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(LivelinessTestPublisher
  SOURCE_FILES Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


add_ace_exe(LivelinessTestSubscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/LivelinessTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(LivelinessTestSubscriber
  SOURCE_FILES DataReaderListener.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/LivelinessTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/LivelinessTest/run_test.pl take"
  COMMAND run_test.pl take
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/LivelinessTest/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/LivelinessTest/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS RTPS
)


add_dds_test("tests/DCPS/LivelinessTest/run_test.pl rtps_disc take"
  COMMAND run_test.pl rtps_disc take
  LABELS RTPS
)
