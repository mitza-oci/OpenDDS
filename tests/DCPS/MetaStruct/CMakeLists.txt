project(MetaStructTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION)

add_ace_lib(MetaStructTest
  OUTPUT_NAME MetaStructTest
  SOURCE_FILES MetaStructTest.cpp
  FOLDER tests/DCPS/MetaStruct
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS MetaStructTest
  IDL_FILES MetaStructTest.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/MetaStruct/run_test.pl"
  COMMAND run_test.pl
)
