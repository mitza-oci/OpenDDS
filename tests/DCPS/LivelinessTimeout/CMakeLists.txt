add_ace_exe(LivelinessTimeout_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES common.cpp
               publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES common.h
               Writer.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/LivelinessTimeout
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(LivelinessTimeout_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES common.cpp
               subscriber.cpp
               DataReaderListenerImpl.cpp
  HEADER_FILES common.h
               DataReaderListenerImpl.h
  FOLDER tests/DCPS/LivelinessTimeout
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/LivelinessTimeout/run_test.pl"
  COMMAND run_test.pl
)
