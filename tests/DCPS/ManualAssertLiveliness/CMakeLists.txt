project(ManualAssertLiveliness CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_ManualAssertLiveliness_Idl
  OUTPUT_NAME DDS_ManualAssertLiveliness_Idl
  FOLDER tests/DCPS/ManualAssertLiveliness
  DEFINE_SYMBOL MANUALASSERTLIVELINESS_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_ManualAssertLiveliness_Idl
  DDS_IDL_FLAGS -Wb,export_macro=ManualAssertLiveliness_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=ManualAssertLiveliness_export.h
                -Wb,stub_export_macro=ManualAssertLiveliness_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_ManualAssertLiveliness_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/ManualAssertLiveliness
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_ManualAssertLiveliness_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_ManualAssertLiveliness_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


add_ace_exe(DDS_ManualAssertLiveliness_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/ManualAssertLiveliness
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_ManualAssertLiveliness_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_ManualAssertLiveliness_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl lost"
  COMMAND run_test.pl lost
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtps lost"
  COMMAND run_test.pl rtps lost
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco"
  COMMAND run_test.pl rtpsdisco
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco lost"
  COMMAND run_test.pl rtpsdisco lost
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco rtps"
  COMMAND run_test.pl rtpsdisco rtps
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco rtps lost"
  COMMAND run_test.pl rtpsdisco rtps lost
  LABELS RTPS
)
