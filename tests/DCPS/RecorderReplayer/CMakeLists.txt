project(RecorderReplayer CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_RecorderReplayer_idl
  OUTPUT_NAME DDS_RecorderReplayer_idl
  FOLDER tests/DCPS/RecorderReplayer
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_RecorderReplayer_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_RecorderReplayer_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER tests/DCPS/RecorderReplayer
  LINK_LIBRARIES DDS_RecorderReplayer_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_RecorderReplayer_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               DataReaderListenerImpl.cpp
  HEADER_FILES DataReaderListenerImpl.h
  FOLDER tests/DCPS/RecorderReplayer
  LINK_LIBRARIES DDS_RecorderReplayer_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_RecorderReplayer_Relay
  OUTPUT_NAME relay
  SOURCE_FILES Relay.cpp
  FOLDER tests/DCPS/RecorderReplayer
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/RecorderReplayer/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/RecorderReplayer/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
