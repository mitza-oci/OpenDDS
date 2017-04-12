project(ManualAssertLiveliness CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_ManualAssertLiveliness_Idl
  OUTPUT_NAME DDS_ManualAssertLiveliness_Idl

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


ace_add_exe(DDS_ManualAssertLiveliness_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_ManualAssertLiveliness_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_ManualAssertLiveliness_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


ace_add_exe(DDS_ManualAssertLiveliness_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_ManualAssertLiveliness_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_ManualAssertLiveliness_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl lost"
  COMMAND run_test.pl lost
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtps lost"
  COMMAND run_test.pl rtps lost
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco"
  COMMAND run_test.pl rtpsdisco
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco lost"
  COMMAND run_test.pl rtpsdisco lost
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco rtps"
  COMMAND run_test.pl rtpsdisco rtps
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManualAssertLiveliness/run_test.pl rtpsdisco rtps lost"
  COMMAND run_test.pl rtpsdisco rtps lost
  LABELS RTPS
)
