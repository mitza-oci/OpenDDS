project(DpShutdown CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_DpShutdown_idl
  OUTPUT_NAME DDS_DpShutdown_idl
  FOLDER tests/DCPS/DpShutdown
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_DpShutdown_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_DpShutdown
  OUTPUT_NAME dpshutdown
  SOURCE_FILES dpshutdown.cpp
  FOLDER tests/DCPS/DpShutdown
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_DpShutdown_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/DpShutdown/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS DCPS_MIN
)
