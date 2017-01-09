project(FACE_idl_test_fixed CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(BUILT_IN_TOPICS)

add_ace_lib(FACE_idl_test_fixed
  OUTPUT_NAME FACE_idl_test_fixed
  FOLDER tests/FACE/Compiler/idl_test_fixed
  ASPECTS FACE
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FACE_idl_test_fixed
  SOURCE_FILES TestFixed.cpp
)

dds_idl_sources(
  TARGETS FACE_idl_test_fixed
  ASPECTS FACE
  IDL_FILES Fixed.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Compiler/idl_test_fixed/run_test.pl"
  COMMAND run_test.pl
)
