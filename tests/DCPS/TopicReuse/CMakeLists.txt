project(TopicReuse CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_TopicReuse_Idl
  OUTPUT_NAME DDS_TopicReuse_Idl
  FOLDER tests/DCPS/TopicReuse
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_TopicReuse_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_TopicReuse_Topicreuse
  OUTPUT_NAME tpreuse
  FOLDER tests/DCPS/TopicReuse
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
                 DDS_TopicReuse_Idl
)
ace_target_cxx_sources(DDS_TopicReuse_Topicreuse
  SOURCE_FILES tpreuse.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/TopicReuse/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS DCPS_MIN
)
