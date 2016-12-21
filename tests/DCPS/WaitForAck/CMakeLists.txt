project(WaitForAck CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE)

add_ace_lib(WaitForAck_idl
  OUTPUT_NAME WaitForAck_idl
  FOLDER tests/DCPS/WaitForAck
  DEFINE_SYMBOL WAITFORACK_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS WaitForAck_idl
  DDS_IDL_FLAGS -Wb,export_macro=WaitForAck_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=WaitForAck_export.h
                -Wb,stub_export_macro=WaitForAck_Export
                -SS
  IDL_FILES Test.idl
)

add_ace_exe(WaitForAck_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Writer.cpp
               Publisher.cpp
               Options.cpp
               publisher_main.cpp
  HEADER_FILES Writer.h
               Publisher.h
               Options.h
  INLINE_FILES Options.inl
  FOLDER tests/DCPS/WaitForAck
  LINK_LIBRARIES WaitForAck_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(WaitForAck_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               Options.cpp
               subscriber_main.cpp
  HEADER_FILES Subscriber.h
               Options.h
  INLINE_FILES Options.inl
  FOLDER tests/DCPS/WaitForAck
  LINK_LIBRARIES WaitForAck_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/WaitForAck/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/WaitForAck/run_test.pl rtps"
  COMMAND run_test.pl rtps
)


add_dds_test("tests/DCPS/WaitForAck/run_test.pl --publisher"
  COMMAND run_test.pl --publisher
)


add_dds_test("tests/DCPS/WaitForAck/run_test.pl rtps --publisher"
  COMMAND run_test.pl rtps --publisher
)
