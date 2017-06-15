ace_add_exe(LivelinessTimeout_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(LivelinessTimeout_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
               common.h
)


ace_add_exe(LivelinessTimeout_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(LivelinessTimeout_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/LivelinessTimeout/run_test.pl"
  COMMAND run_test.pl
)

dds_add_test("tests/DCPS/LivelinessTimeout/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS RTPS
)
