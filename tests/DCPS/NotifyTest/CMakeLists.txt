project(NotifyTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_NotifyTest_Idl
  OUTPUT_NAME DDS_NotifyTest_Idl
  FOLDER tests/DCPS/NotifyTest
  DEFINE_SYMBOL NOTIFYTEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_NotifyTest_Idl
  DDS_IDL_FLAGS -Wb,export_macro=NotifyTest_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=NotifyTest_export.h
                -Wb,stub_export_macro=NotifyTest_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_NotifyTest_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/NotifyTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_NotifyTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_NotifyTest_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_NotifyTest_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/NotifyTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_NotifyTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_NotifyTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/NotifyTest/run_test.pl"
  COMMAND run_test.pl
)
