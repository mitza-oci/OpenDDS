project(ManualAssertLiveliness CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_ManualAssertLiveliness_idl
  OUTPUT_NAME DDS_ManualAssertLiveliness_idl
  FOLDER tests/DCPS/ManualAssertLiveliness
  DEFINE_SYMBOL MANUALASSERTLIVELINESS_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_ManualAssertLiveliness_idl
  DDS_IDL_FLAGS -Wb,export_macro=ManualAssertLiveliness_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=ManualAssertLiveliness_export.h
                -Wb,stub_export_macro=ManualAssertLiveliness_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_ManualAssertLiveliness_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES Writer.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/ManualAssertLiveliness
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_ManualAssertLiveliness_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_ManualAssertLiveliness_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/ManualAssertLiveliness
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_ManualAssertLiveliness_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
