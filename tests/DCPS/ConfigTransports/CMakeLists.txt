requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(ConfigTransports_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES common.cpp
               publisher.cpp
               Options.cpp
               Factory.cpp
               Pusher.cpp
               DDSTEST.cpp
               DataWriterListenerImpl.cpp
               DataReaderListener.cpp
  HEADER_FILES common.h
               Options.h
               Factory.h
               Pusher.h
               DDSTEST.h
               DataWriterListenerImpl.h
               DataReaderListener.h
  FOLDER tests/DCPS/ConfigTransports
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(ConfigTransports_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES common.cpp
               subscriber.cpp
               Options.cpp
               Factory.cpp
               Puller.cpp
               DDSTEST.cpp
               DataWriterListenerImpl.cpp
               DataReaderListener.cpp
  HEADER_FILES common.h
               Options.h
               Factory.h
               Puller.h
               DDSTEST.h
               DataWriterListenerImpl.h
               DataReaderListener.h
  FOLDER tests/DCPS/ConfigTransports
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/ConfigTransports/run_test.pl"
  COMMAND run_test.pl
)
