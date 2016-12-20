project(Priority CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(DDS_Priority_idl
  OUTPUT_NAME DDS_Priority_idl
  FOLDER tests/DCPS/Priority
  DEFINE_SYMBOL PRIORITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_Priority_idl
  DDS_IDL_FLAGS -Wb,export_macro=Priority_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Priority_export.h
                -Wb,stub_export_macro=Priority_Export
                -SS
  IDL_FILES Test.idl
)

add_ace_exe(DDS_Priority_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
               Options.cpp
               publisher_main.cpp
  HEADER_FILES Publisher.h
               Options.h
  INLINE_FILES Options.inl
  FOLDER tests/DCPS/Priority
  LINK_LIBRARIES DDS_Priority_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Priority_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               Options.cpp
               DataReaderListener.cpp
               subscriber_main.cpp
  HEADER_FILES Subscriber.h
               Options.h
               DataReaderListener.h
  INLINE_FILES Options.inl
  FOLDER tests/DCPS/Priority
  LINK_LIBRARIES DDS_Priority_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/Priority/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/Priority/run_test.pl --instances"
  COMMAND run_test.pl --instances
)
