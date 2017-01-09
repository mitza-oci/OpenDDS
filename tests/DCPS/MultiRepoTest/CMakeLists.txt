requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(MultiRepoTest_Monitor
  OUTPUT_NAME monitor
  FOLDER tests/DCPS/MultiRepoTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType5
                 OpenDDS_Dcps
)
target_cxx_sources(MultiRepoTest_Monitor
  SOURCE_FILES DataWriterListenerImpl.cpp
               ForwardingListener.cpp
               TestConfig.cpp
               TestMonitor.cpp
               monitor.cpp
  HEADER_FILES DataWriterListenerImpl.h
               ForwardingListener.h
               TestConfig.h
               TestMonitor.h
)


add_ace_exe(MultiRepoTest_System
  OUTPUT_NAME system
  FOLDER tests/DCPS/MultiRepoTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType5
                 OpenDDS_Dcps
)
target_cxx_sources(MultiRepoTest_System
  SOURCE_FILES DataWriterListenerImpl.cpp
               ForwardingListener.cpp
               TestConfig.cpp
               TestSystem.cpp
               system.cpp
  HEADER_FILES DataWriterListenerImpl.h
               ForwardingListener.h
               TestConfig.h
               TestSystem.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/MultiRepoTest/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/MultiRepoTest/run_test.pl fileconfig"
  COMMAND run_test.pl fileconfig
)
