project(KeyTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_KeyTest_Idl
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


ace_add_exe(DDS_KeyTest_Isbounded
  OUTPUT_NAME IsBounded
  FOLDER tests/DCPS/KeyTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Rtps
                 DDS_KeyTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_KeyTest_Isbounded
  SOURCE_FILES IsBounded.cpp
)


ace_add_exe(DDS_KeyTest_Keymarshalling
  OUTPUT_NAME KeyMarshalling
  FOLDER tests/DCPS/KeyTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Rtps
                 DDS_KeyTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_KeyTest_Keymarshalling
  SOURCE_FILES KeyMarshalling.cpp
)


ace_add_exe(KeyTest_MD5
  OUTPUT_NAME KeyTest_MD5
  FOLDER tests/DCPS/KeyTest
  LINK_LIBRARIES OpenDDS_Rtps
)
ace_target_cxx_sources(KeyTest_MD5
  SOURCE_FILES md5_test.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/KeyTest/run_test.pl keymarshalling"
  COMMAND run_test.pl keymarshalling
)


dds_add_test("tests/DCPS/KeyTest/run_test.pl isbounded"
  COMMAND run_test.pl isbounded
)


dds_add_test("tests/DCPS/KeyTest/run_test.pl md5"
  COMMAND run_test.pl md5
)


dds_add_test("tests/DCPS/KeyTest/run_test.pl compiler"
  COMMAND run_test.pl compiler
  LABELS HOST
)
