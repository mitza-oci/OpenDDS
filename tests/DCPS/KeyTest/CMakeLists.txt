project(KeyTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_KeyTest_Idl
  OUTPUT_NAME DDS_KeyTest_Idl
  FOLDER tests/DCPS/KeyTest
  DEFINE_SYMBOL KEYTEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_KeyTest_Idl
  DDS_IDL_FLAGS -Wb,export_macro=KeyTest_Export
  TAO_IDL_FLAGS -Wb,export_include=KeyTest_export.h
                -Wb,export_macro=KeyTest_Export
                -SS
  IDL_FILES KeyTest.idl
            KeyTest2.idl
            BoundTest.idl
            BoundTest2.idl
)

if (MSVC)
  target_compile_options(DDS_KeyTest_Idl /bigobj)
endif()


add_ace_exe(DDS_KeyTest_Isbounded
  OUTPUT_NAME IsBounded
  FOLDER tests/DCPS/KeyTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Rtps
                 DDS_KeyTest_Idl
)
target_cxx_sources(DDS_KeyTest_Isbounded
  SOURCE_FILES IsBounded.cpp
)


add_ace_exe(DDS_KeyTest_Keymarshalling
  OUTPUT_NAME KeyMarshalling
  FOLDER tests/DCPS/KeyTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Rtps
                 DDS_KeyTest_Idl
)
target_cxx_sources(DDS_KeyTest_Keymarshalling
  SOURCE_FILES KeyMarshalling.cpp
)


add_ace_exe(KeyTest_Md5
  OUTPUT_NAME KeyTest_Md5
  FOLDER tests/DCPS/KeyTest
  LINK_LIBRARIES OpenDDS_Rtps
)
target_cxx_sources(KeyTest_Md5
  SOURCE_FILES md5_test.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/KeyTest/run_test.pl keymarshalling"
  COMMAND run_test.pl keymarshalling
)


add_dds_test("tests/DCPS/KeyTest/run_test.pl isbounded"
  COMMAND run_test.pl isbounded
)


add_dds_test("tests/DCPS/KeyTest/run_test.pl md5"
  COMMAND run_test.pl md5
)


add_dds_test("tests/DCPS/KeyTest/run_test.pl compiler"
  COMMAND run_test.pl compiler
  LABELS HOST
)
