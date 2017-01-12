project(sub_init_loop CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(sub_init_loop_Idl
  OUTPUT_NAME sub_init_loop_Idl
  FOLDER tests/DCPS/sub_init_loop
  DEFINE_SYMBOL SUBINITLOOP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS sub_init_loop_Idl
  DDS_IDL_FLAGS -Wb,export_macro=SubInitLoop_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SubInitLoop_export.h
                -Wb,stub_export_macro=SubInitLoop_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(sub_init_loop_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/sub_init_loop
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES sub_init_loop_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(sub_init_loop_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(sub_init_loop_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/sub_init_loop
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES sub_init_loop_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(sub_init_loop_Subscriber
  SOURCE_FILES subscriber.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/sub_init_loop/run_test.pl"
  COMMAND run_test.pl
)
