project(Priority CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

ace_add_lib(DDS_Priority_Idl
  OUTPUT_NAME DDS_Priority_Idl
  FOLDER tests/DCPS/Priority
  DEFINE_SYMBOL PRIORITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Priority_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Priority_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Priority_export.h
                -Wb,stub_export_macro=Priority_Export
                -SS
  IDL_FILES Test.idl
)


ace_add_exe(DDS_Priority_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Priority
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Priority_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Priority_Publisher
  SOURCE_FILES Options.cpp
               Publisher.cpp
               publisher_main.cpp
  HEADER_FILES Options.h
               Publisher.h
  INLINE_FILES Options.inl
)
ace_target_cxx_sources(DDS_Priority_Publisher
  SOURCE_FILES Options.cpp
               Publisher.cpp
               publisher_main.cpp
  HEADER_FILES Options.h
               Publisher.h
  INLINE_FILES Options.inl
)



ace_add_exe(DDS_Priority_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Priority
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Priority_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Priority_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               Options.cpp
               Subscriber.cpp
               subscriber_main.cpp
  HEADER_FILES DataReaderListener.h
               Options.h
               Subscriber.h
  INLINE_FILES Options.inl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Priority/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/Priority/run_test.pl --instances"
  COMMAND run_test.pl --instances
)
