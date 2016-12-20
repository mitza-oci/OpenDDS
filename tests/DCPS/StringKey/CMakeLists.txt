project(StringKey CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_StringKey_idl
  OUTPUT_NAME DDS_StringKey_idl
  FOLDER tests/DCPS/StringKey
  DEFINE_SYMBOL STRINGKEY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_StringKey_idl
  DDS_IDL_FLAGS -Wb,export_macro=StringKey_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=StringKey_export.h
                -Wb,stub_export_macro=StringKey_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_StringKey_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/StringKey
  LINK_LIBRARIES DDS_StringKey_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_StringKey_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/StringKey
  LINK_LIBRARIES DDS_StringKey_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/StringKey/run_test.pl"
  COMMAND run_test.pl
)
