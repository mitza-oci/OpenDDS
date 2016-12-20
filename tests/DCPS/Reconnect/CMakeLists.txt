project(Reconnect CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(Reconnect_idl
  OUTPUT_NAME Reconnect_idl
  FOLDER tests/DCPS/Reconnect
  DEFINE_SYMBOL RECONNECT_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS Reconnect_idl
  DDS_IDL_FLAGS -Wb,export_macro=Reconnect_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Reconnect_export.h
                -Wb,stub_export_macro=Reconnect_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(Reconnect_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
               DataWriterListener.cpp
  HEADER_FILES Writer.h
               DataWriterListener.h
  FOLDER tests/DCPS/Reconnect
  LINK_LIBRARIES OpenDDS_Tcp
                 Reconnect_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(Reconnect_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Reconnect
  LINK_LIBRARIES OpenDDS_Tcp
                 Reconnect_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/Reconnect/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/Reconnect/run_test.pl restart_sub"
  COMMAND run_test.pl restart_sub
)


add_dds_test("tests/DCPS/Reconnect/run_test.pl restart_pub"
  COMMAND run_test.pl restart_pub
)


add_dds_test("tests/DCPS/Reconnect/run_test.pl bp_timeout"
  COMMAND run_test.pl bp_timeout
)


add_dds_test("tests/DCPS/Reconnect/run_test.pl sub_init_crash"
  COMMAND run_test.pl sub_init_crash
)
