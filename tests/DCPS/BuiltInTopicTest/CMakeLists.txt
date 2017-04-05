project(BuiltInTopicTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE OPENDDS_HAS_BUILT_IN_TOPICS)

ace_add_lib(DDS_BuiltInTopicTest_Idl
  OUTPUT_NAME DDS_BuiltInTopicTest_Idl

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


ace_add_exe(DDS_BuiltInTopicTest_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_BuiltInTopicTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_BuiltInTopicTest_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)
ace_target_cxx_sources(DDS_BuiltInTopicTest_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)



ace_add_exe(DDS_BuiltInTopicTest_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_BuiltInTopicTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_BuiltInTopicTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)


ace_add_exe(DDS_BuiltInTopicTest_Monitor
  OUTPUT_NAME monitor

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_BuiltInTopicTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_BuiltInTopicTest_Monitor
  SOURCE_FILES monitor.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/BuiltInTopicTest/run_test.pl"
  COMMAND run_test.pl
  LABELS HOST
)


dds_add_test("tests/DCPS/BuiltInTopicTest/prst_repo_run_test.pl"
  COMMAND prst_repo_run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)
