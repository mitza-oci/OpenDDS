project(FACE_idl_test_fixed CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(BUILT_IN_TOPICS)

add_ace_lib(FACE_idl_test_fixed
  OUTPUT_NAME FACE_idl_test_fixed
  SOURCE_FILES TestFixed.cpp
  FOLDER tests/FACE/Compiler/idl_test_fixed
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
add_face_idl_files(
  TARGETS FACE_idl_test_fixed
  IDL_FILES Fixed.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Compiler/idl_test_fixed/run_test.pl"
  COMMAND run_test.pl
)
