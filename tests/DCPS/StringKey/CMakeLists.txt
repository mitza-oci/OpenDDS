project(StringKey CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_StringKey_Idl
  OUTPUT_NAME DDS_StringKey_Idl

  DEFINE_SYMBOL STRINGKEY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_StringKey_Idl
  DDS_IDL_FLAGS -Wb,export_macro=StringKey_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=StringKey_export.h
                -Wb,stub_export_macro=StringKey_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_StringKey_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_StringKey_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_StringKey_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_StringKey_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_StringKey_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_StringKey_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/StringKey/run_test.pl"
  COMMAND run_test.pl
)
