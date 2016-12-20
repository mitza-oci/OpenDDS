project(Prst_delayed_subscriber CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(DDS_Prst_delayed_subscriber_idl
  OUTPUT_NAME DDS_Prst_delayed_subscriber_idl
  FOLDER tests/DCPS/Prst_delayed_subscriber
  DEFINE_SYMBOL PRST_DELAYED_SUBSCRIBER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_Prst_delayed_subscriber_idl
  DDS_IDL_FLAGS -Wb,export_macro=Prst_delayed_subscriber_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Prst_delayed_subscriber_export.h
                -Wb,stub_export_macro=Prst_delayed_subscriber_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Prst_delayed_subscriber_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Prst_delayed_subscriber
  LINK_LIBRARIES DDS_Prst_delayed_subscriber_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Prst_delayed_subscriber_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Prst_delayed_subscriber
  LINK_LIBRARIES DDS_Prst_delayed_subscriber_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/Prst_delayed_subscriber/run_test.pl"
  COMMAND run_test.pl
)
