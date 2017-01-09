add_ace_exe(Thrasher_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Thrasher
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
target_cxx_sources(Thrasher_Publisher
  SOURCE_FILES ParticipantTask.cpp
               ProgressIndicator.cpp
               Publisher.cpp
  HEADER_FILES ParticipantTask.h
               ProgressIndicator.h
)


add_ace_exe(Thrasher_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Thrasher
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
target_cxx_sources(Thrasher_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               ProgressIndicator.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
               ProgressIndicator.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


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
