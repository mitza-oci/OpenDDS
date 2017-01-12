project(Prst_delayed_subscriber CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(DDS_Prst_delayed_subscriber_Idl
  OUTPUT_NAME DDS_Prst_delayed_subscriber_Idl
  FOLDER tests/DCPS/Prst_delayed_subscriber
  DEFINE_SYMBOL PRST_DELAYED_SUBSCRIBER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Prst_delayed_subscriber_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Prst_delayed_subscriber_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Prst_delayed_subscriber_export.h
                -Wb,stub_export_macro=Prst_delayed_subscriber_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_Prst_delayed_subscriber_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Prst_delayed_subscriber
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Prst_delayed_subscriber_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Prst_delayed_subscriber_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_Prst_delayed_subscriber_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Prst_delayed_subscriber
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Prst_delayed_subscriber_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Prst_delayed_subscriber_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Prst_delayed_subscriber/run_test.pl"
  COMMAND run_test.pl
)
