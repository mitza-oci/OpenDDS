project(RecorderReplayer CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_RecorderReplayer_Idl
  OUTPUT_NAME DDS_RecorderReplayer_Idl
  FOLDER tests/DCPS/RecorderReplayer
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


add_ace_exe(DDS_RecorderReplayer_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/RecorderReplayer
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_RecorderReplayer_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_RecorderReplayer_Publisher
  SOURCE_FILES Publisher.cpp
)


add_ace_exe(DDS_RecorderReplayer_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/RecorderReplayer
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_RecorderReplayer_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_RecorderReplayer_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
)


add_ace_exe(DDS_RecorderReplayer_Relay
  OUTPUT_NAME relay
  FOLDER tests/DCPS/RecorderReplayer
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(DDS_RecorderReplayer_Relay
  SOURCE_FILES Relay.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/RecorderReplayer/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/RecorderReplayer/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
