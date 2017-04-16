project(RecorderReplayer CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_RecorderReplayer_Idl
  OUTPUT_NAME DDS_RecorderReplayer_Idl
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_RecorderReplayer_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_RecorderReplayer_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_RecorderReplayer_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_RecorderReplayer_Publisher
  SOURCE_FILES Publisher.cpp
)


ace_add_exe(DDS_RecorderReplayer_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_RecorderReplayer_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_RecorderReplayer_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
)


ace_add_exe(DDS_RecorderReplayer_Relay
  OUTPUT_NAME relay

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_RecorderReplayer_Relay
  SOURCE_FILES Relay.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/RecorderReplayer/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/RecorderReplayer/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
