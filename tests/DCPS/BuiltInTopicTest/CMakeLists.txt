project(BuiltInTopicTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE BUILT_IN_TOPICS)

add_ace_lib(DDS_BuiltInTopicTest_idl
  OUTPUT_NAME DDS_BuiltInTopicTest_idl
  FOLDER tests/DCPS/BuiltInTopicTest
  DEFINE_SYMBOL BUILTINTOPICTEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_BuiltInTopicTest_idl
  DDS_IDL_FLAGS -Wb,export_macro=BuiltInTopicTest_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=BuiltInTopicTest_export.h
                -Wb,stub_export_macro=BuiltInTopicTest_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_BuiltInTopicTest_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/BuiltInTopicTest
  LINK_LIBRARIES DDS_BuiltInTopicTest_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_BuiltInTopicTest_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/BuiltInTopicTest
  LINK_LIBRARIES DDS_BuiltInTopicTest_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_BuiltInTopicTest_Monitor
  OUTPUT_NAME monitor
  SOURCE_FILES monitor.cpp
  FOLDER tests/DCPS/BuiltInTopicTest
  LINK_LIBRARIES DDS_BuiltInTopicTest_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/BuiltInTopicTest/run_test.pl"
  COMMAND run_test.pl
  LABELS HOST
)


add_dds_test("tests/DCPS/BuiltInTopicTest/prst_repo_run_test.pl"
  COMMAND prst_repo_run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)
