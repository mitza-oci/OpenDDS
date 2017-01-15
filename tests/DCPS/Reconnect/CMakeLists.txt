project(Reconnect CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

ace_add_lib(Reconnect_Idl
  OUTPUT_NAME Reconnect_Idl
  FOLDER tests/DCPS/Reconnect
  DEFINE_SYMBOL RECONNECT_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS Reconnect_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Reconnect_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Reconnect_export.h
                -Wb,stub_export_macro=Reconnect_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(Reconnect_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Reconnect
  LINK_LIBRARIES OpenDDS_Tcp
                 Reconnect_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Reconnect_Publisher
  SOURCE_FILES DataWriterListener.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListener.h
               Writer.h
)


ace_add_exe(Reconnect_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Reconnect
  LINK_LIBRARIES OpenDDS_Tcp
                 Reconnect_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Reconnect_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Reconnect/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/Reconnect/run_test.pl restart_sub"
  COMMAND run_test.pl restart_sub
)


dds_add_test("tests/DCPS/Reconnect/run_test.pl restart_pub"
  COMMAND run_test.pl restart_pub
)


dds_add_test("tests/DCPS/Reconnect/run_test.pl bp_timeout"
  COMMAND run_test.pl bp_timeout
)


dds_add_test("tests/DCPS/Reconnect/run_test.pl sub_init_crash"
  COMMAND run_test.pl sub_init_crash
)
