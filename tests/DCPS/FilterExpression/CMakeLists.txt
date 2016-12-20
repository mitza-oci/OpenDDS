project(FilterExpressionTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION)

add_ace_exe(FilterExpressionTest
  OUTPUT_NAME FilterExpressionTest
  SOURCE_FILES FilterExpression.cpp
  FOLDER tests/DCPS/FilterExpression
  LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS FilterExpressionTest
  IDL_FILES FilterStruct.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/FilterExpression/run_test.pl"
  COMMAND run_test.pl
)
