project(TopicReuse CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_TopicReuse_idl
  OUTPUT_NAME DDS_TopicReuse_idl
  FOLDER tests/DCPS/TopicReuse
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_TopicReuse_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_TopicReuse_TopicReuse
  OUTPUT_NAME tpreuse
  SOURCE_FILES tpreuse.cpp
  FOLDER tests/DCPS/TopicReuse
  LINK_LIBRARIES DDS_TopicReuse_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/TopicReuse/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS DCPS_MIN
)
