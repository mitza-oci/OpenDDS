requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(ConfigTransports_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/ConfigTransports
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(ConfigTransports_Publisher
  SOURCE_FILES DDSTEST.cpp
               DataReaderListener.cpp
               DataWriterListenerImpl.cpp
               Factory.cpp
               Options.cpp
               Pusher.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES DDSTEST.h
               DataReaderListener.h
               DataWriterListenerImpl.h
               Factory.h
               Options.h
               Pusher.h
               common.h
)


add_ace_exe(ConfigTransports_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/ConfigTransports
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(ConfigTransports_Subscriber
  SOURCE_FILES DDSTEST.cpp
               DataReaderListener.cpp
               DataWriterListenerImpl.cpp
               Factory.cpp
               Options.cpp
               Puller.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DDSTEST.h
               DataReaderListener.h
               DataWriterListenerImpl.h
               Factory.h
               Options.h
               Puller.h
               common.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ConfigTransports/run_test.pl"
  COMMAND run_test.pl
)
