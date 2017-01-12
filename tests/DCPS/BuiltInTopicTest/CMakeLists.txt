project(BuiltInTopicTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE BUILT_IN_TOPICS)

add_ace_lib(DDS_BuiltInTopicTest_Idl
  OUTPUT_NAME DDS_BuiltInTopicTest_Idl
  FOLDER tests/DCPS/BuiltInTopicTest
  DEFINE_SYMBOL BUILTINTOPICTEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_BuiltInTopicTest_Idl
  DDS_IDL_FLAGS -Wb,export_macro=BuiltInTopicTest_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=BuiltInTopicTest_export.h
                -Wb,stub_export_macro=BuiltInTopicTest_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_BuiltInTopicTest_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/BuiltInTopicTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_BuiltInTopicTest_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_BuiltInTopicTest_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_BuiltInTopicTest_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/BuiltInTopicTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_BuiltInTopicTest_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_BuiltInTopicTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)


add_ace_exe(DDS_BuiltInTopicTest_Monitor
  OUTPUT_NAME monitor
  FOLDER tests/DCPS/BuiltInTopicTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_BuiltInTopicTest_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_BuiltInTopicTest_Monitor
  SOURCE_FILES monitor.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/BuiltInTopicTest/run_test.pl"
  COMMAND run_test.pl
  LABELS HOST
)


add_dds_test("tests/DCPS/BuiltInTopicTest/prst_repo_run_test.pl"
  COMMAND prst_repo_run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)
