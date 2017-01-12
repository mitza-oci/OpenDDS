ace_requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(DCPS_Perf_TCPListener_Pub
  OUTPUT_NAME publisher
  FOLDER performance-tests/DCPS/TCPListenerTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DCPS_Perf_TCPListener_Pub
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


ace_add_exe(DCPS_Perf_TCPListener_Sub
  OUTPUT_NAME subscriber
  FOLDER performance-tests/DCPS/TCPListenerTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DCPS_Perf_TCPListener_Sub
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               TestStats.h
               common.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 1 -s 1"
  COMMAND run_test.pl -p 1 -s 1
)


dds_add_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 1 -s 1 -c"
  COMMAND run_test.pl -p 1 -s 1 -c
)


dds_add_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 1 -s 4"
  COMMAND run_test.pl -p 1 -s 4
)


dds_add_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 2 -s 3"
  COMMAND run_test.pl -p 2 -s 3
)


dds_add_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 4 -s 1"
  COMMAND run_test.pl -p 4 -s 1
)
