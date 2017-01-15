project(DpShutdown CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_DpShutdown_Idl
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


ace_add_exe(DDS_DpShutdown
  OUTPUT_NAME dpshutdown
  FOLDER tests/DCPS/DpShutdown
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_DpShutdown_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_DpShutdown
  SOURCE_FILES dpshutdown.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/DpShutdown/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS DCPS_MIN
)
