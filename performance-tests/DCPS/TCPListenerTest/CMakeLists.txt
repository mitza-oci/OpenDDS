requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DCPS_Perf_TCPListener_Pub
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES common.h
               Writer.h
  FOLDER performance-tests/DCPS/TCPListenerTest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DCPS_Perf_TCPListener_Sub
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES common.h
               TestStats.h
               DataReaderListener.h
  FOLDER performance-tests/DCPS/TCPListenerTest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 1 -s 1"
  COMMAND run_test.pl -p 1 -s 1
)


add_dds_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 1 -s 1 -c"
  COMMAND run_test.pl -p 1 -s 1 -c
)


add_dds_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 1 -s 4"
  COMMAND run_test.pl -p 1 -s 4
)


add_dds_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 2 -s 3"
  COMMAND run_test.pl -p 2 -s 3
)


add_dds_test("performance-tests/DCPS/TCPListenerTest/run_test.pl -p 4 -s 1"
  COMMAND run_test.pl -p 4 -s 1
)
