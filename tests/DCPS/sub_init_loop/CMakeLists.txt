project(sub_init_loop CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(sub_init_loop_idl
  OUTPUT_NAME sub_init_loop_idl
  FOLDER tests/DCPS/sub_init_loop
  DEFINE_SYMBOL SUBINITLOOP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS sub_init_loop_idl
  DDS_IDL_FLAGS -Wb,export_macro=SubInitLoop_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SubInitLoop_export.h
                -Wb,stub_export_macro=SubInitLoop_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(sub_init_loop_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/sub_init_loop
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 sub_init_loop_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(sub_init_loop_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
  FOLDER tests/DCPS/sub_init_loop
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 sub_init_loop_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/sub_init_loop/run_test.pl"
  COMMAND run_test.pl
)
