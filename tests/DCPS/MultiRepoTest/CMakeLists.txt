ace_requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(MultiRepoTest_Monitor
  OUTPUT_NAME monitor
  FOLDER tests/DCPS/MultiRepoTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(MultiRepoTest_Monitor
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


ace_add_exe(MultiRepoTest_System
  OUTPUT_NAME system
  FOLDER tests/DCPS/MultiRepoTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(MultiRepoTest_System
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

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MultiRepoTest/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/MultiRepoTest/run_test.pl fileconfig"
  COMMAND run_test.pl fileconfig
)
