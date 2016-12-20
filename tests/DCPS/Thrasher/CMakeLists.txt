add_ace_exe(Thrasher_publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
               ParticipantTask.cpp
               ProgressIndicator.cpp
  HEADER_FILES ParticipantTask.h
               ProgressIndicator.h
  FOLDER tests/DCPS/Thrasher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(Thrasher_subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               DataReaderListenerImpl.cpp
               ProgressIndicator.cpp
  HEADER_FILES DataReaderListenerImpl.h
               ProgressIndicator.h
  FOLDER tests/DCPS/Thrasher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/Thrasher/run_test.pl single"
  COMMAND run_test.pl single
)


add_dds_test("tests/DCPS/Thrasher/run_test.pl default"
  COMMAND run_test.pl default
)


add_dds_test("tests/DCPS/Thrasher/run_test.pl low"
  COMMAND run_test.pl low
)


add_dds_test("tests/DCPS/Thrasher/run_test.pl medium"
  COMMAND run_test.pl medium
)


add_dds_test("tests/DCPS/Thrasher/run_test.pl high"
  COMMAND run_test.pl high
)


add_dds_test("tests/DCPS/Thrasher/run_test.pl aggressive"
  COMMAND run_test.pl aggressive
)
