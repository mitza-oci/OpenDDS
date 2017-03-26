ace_add_exe(Thrasher_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Thrasher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Thrasher_Publisher
  SOURCE_FILES ParticipantTask.cpp
               ProgressIndicator.cpp
               Publisher.cpp
  HEADER_FILES ParticipantTask.h
               ProgressIndicator.h
)


ace_add_exe(Thrasher_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Thrasher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Thrasher_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               ProgressIndicator.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
               ProgressIndicator.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Thrasher/run_test.pl single"
  COMMAND run_test.pl single
)


dds_add_test("tests/DCPS/Thrasher/run_test.pl default"
  COMMAND run_test.pl default
)


dds_add_test("tests/DCPS/Thrasher/run_test.pl low"
  COMMAND run_test.pl low
)


dds_add_test("tests/DCPS/Thrasher/run_test.pl medium"
  COMMAND run_test.pl medium
)


dds_add_test("tests/DCPS/Thrasher/run_test.pl high"
  COMMAND run_test.pl high
)


dds_add_test("tests/DCPS/Thrasher/run_test.pl aggressive"
  COMMAND run_test.pl aggressive
)
