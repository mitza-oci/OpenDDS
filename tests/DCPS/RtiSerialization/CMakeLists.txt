project(RtiSerialization CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_RtiSerialization_Idl
  OUTPUT_NAME DDS_RtiSerialization_Idl
  FOLDER tests/DCPS/RtiSerialization
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_RtiSerialization_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_RtiSerialization_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/RtiSerialization
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_RtiSerialization_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_RtiSerialization_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_RtiSerialization_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/RtiSerialization
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_RtiSerialization_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_RtiSerialization_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/RtiSerialization/run_test.pl"
  COMMAND run_test.pl
  LABELS TCP
)


add_dds_test("tests/DCPS/RtiSerialization/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)
