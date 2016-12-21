requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(MultiRepoTest_Monitor
  OUTPUT_NAME monitor
  SOURCE_FILES monitor.cpp
               TestMonitor.cpp
               TestConfig.cpp
               DataWriterListenerImpl.cpp
               ForwardingListener.cpp
  HEADER_FILES TestMonitor.h
               TestConfig.h
               DataWriterListenerImpl.h
               ForwardingListener.h
  FOLDER tests/DCPS/MultiRepoTest
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DcpsFooType5
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(MultiRepoTest_System
  OUTPUT_NAME system
  SOURCE_FILES system.cpp
               TestSystem.cpp
               TestConfig.cpp
               DataWriterListenerImpl.cpp
               ForwardingListener.cpp
  HEADER_FILES TestSystem.h
               TestConfig.h
               DataWriterListenerImpl.h
               ForwardingListener.h
  FOLDER tests/DCPS/MultiRepoTest
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DcpsFooType5
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/MultiRepoTest/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/MultiRepoTest/run_test.pl fileconfig"
  COMMAND run_test.pl fileconfig
)
