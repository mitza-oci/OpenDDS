project(StringKey CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_StringKey_Idl
  OUTPUT_NAME DDS_StringKey_Idl
  FOLDER tests/DCPS/StringKey
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


add_ace_exe(DDS_StringKey_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/StringKey
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
                 DDS_StringKey_Idl
)
target_cxx_sources(DDS_StringKey_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_StringKey_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/StringKey
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
                 DDS_StringKey_Idl
)
target_cxx_sources(DDS_StringKey_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/StringKey/run_test.pl"
  COMMAND run_test.pl
)
