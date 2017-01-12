project(WaitForAck CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE)

add_ace_lib(WaitForAck_Idl
  OUTPUT_NAME WaitForAck_Idl
  FOLDER tests/DCPS/WaitForAck
  DEFINE_SYMBOL WAITFORACK_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS WaitForAck_Idl
  DDS_IDL_FLAGS -Wb,export_macro=WaitForAck_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=WaitForAck_export.h
                -Wb,stub_export_macro=WaitForAck_Export
                -SS
  IDL_FILES Test.idl
)


add_ace_exe(WaitForAck_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/WaitForAck
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES WaitForAck_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(WaitForAck_Publisher
  SOURCE_FILES Options.cpp
               Publisher.cpp
               Writer.cpp
               publisher_main.cpp
  HEADER_FILES Options.h
               Publisher.h
               Writer.h
  INLINE_FILES Options.inl
)


add_ace_exe(WaitForAck_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/WaitForAck
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES WaitForAck_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(WaitForAck_Subscriber
  SOURCE_FILES Options.cpp
               Subscriber.cpp
               subscriber_main.cpp
  HEADER_FILES Options.h
               Subscriber.h
  INLINE_FILES Options.inl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
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
