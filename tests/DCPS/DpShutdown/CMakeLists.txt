project(DpShutdown CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_DpShutdown_Idl
  OUTPUT_NAME DDS_DpShutdown_Idl
  FOLDER tests/DCPS/DpShutdown
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_DpShutdown_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_DpShutdown
  OUTPUT_NAME dpshutdown
  FOLDER tests/DCPS/DpShutdown
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_DpShutdown_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_DpShutdown
  SOURCE_FILES dpshutdown.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/DpShutdown/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS DCPS_MIN
)
