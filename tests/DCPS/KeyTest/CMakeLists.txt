project(KeyTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_KeyTest_idl
  OUTPUT_NAME DDS_KeyTest_idl
  FOLDER tests/DCPS/KeyTest
  DEFINE_SYMBOL KEYTEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
if (MSVC)
  target_compile_options(DDS_KeyTest_idl /bigobj)
endif()
add_dds_idl_files(
  TARGETS DDS_KeyTest_idl
  DDS_IDL_FLAGS -Wb,export_macro=KeyTest_Export
  TAO_IDL_FLAGS -Wb,export_include=KeyTest_export.h
                -Wb,export_macro=KeyTest_Export
                -SS
  IDL_FILES KeyTest.idl
            KeyTest2.idl
            BoundTest.idl
            BoundTest2.idl
)

add_ace_exe(DDS_KeyTest_IsBounded
  OUTPUT_NAME IsBounded
  SOURCE_FILES IsBounded.cpp
  FOLDER tests/DCPS/KeyTest
  LINK_LIBRARIES DDS_KeyTest_idl
                 OpenDDS_Rtps
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_KeyTest_KeyMarshalling
  OUTPUT_NAME KeyMarshalling
  SOURCE_FILES KeyMarshalling.cpp
  FOLDER tests/DCPS/KeyTest
  LINK_LIBRARIES DDS_KeyTest_idl
                 OpenDDS_Rtps
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(KeyTest_MD5
  OUTPUT_NAME KeyTest_MD5
  SOURCE_FILES md5_test.cpp
  FOLDER tests/DCPS/KeyTest
  LINK_LIBRARIES OpenDDS_Rtps
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
