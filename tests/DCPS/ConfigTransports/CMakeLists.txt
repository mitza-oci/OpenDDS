ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(ConfigTransports_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ConfigTransports_Publisher
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


ace_add_exe(ConfigTransports_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ConfigTransports_Subscriber
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

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()

foreach(i RANGE 16)
  dds_add_test("tests/DCPS/ConfigTransports/run_test.pl -i ${i}"
    COMMAND run_test.pl -i ${i}
    NO_LOCK
  )
endforeach()
