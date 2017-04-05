project(FACE_idl_test_fixed CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("TARGET OpenDDS_FACE")

ace_add_exe(FACE_idl_test_fixed
  OUTPUT_NAME TestFixed

  LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FACE_idl_test_fixed
  SOURCE_FILES TestFixed.cpp
)

dds_idl_sources(
  TARGETS FACE_idl_test_fixed
  IDL_FILES Fixed.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Compiler/idl_test_fixed/run_test.pl"
  COMMAND run_test.pl
  LABELS FACE
)
