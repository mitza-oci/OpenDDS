add_ace_exe(LivelinessTimeout_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/LivelinessTimeout
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(LivelinessTimeout_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
               common.h
)


add_ace_exe(LivelinessTimeout_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/LivelinessTimeout
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(LivelinessTimeout_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
               common.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/LivelinessTimeout/run_test.pl"
  COMMAND run_test.pl
)
