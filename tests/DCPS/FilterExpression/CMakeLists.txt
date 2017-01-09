project(FilterExpressionTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION)

add_ace_exe(FilterExpressionTest
  OUTPUT_NAME FilterExpressionTest
  FOLDER tests/DCPS/FilterExpression
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FilterExpressionTest
  SOURCE_FILES FilterExpression.cpp
)

dds_idl_sources(
  TARGETS FilterExpressionTest
  IDL_FILES FilterStruct.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/FilterExpression/run_test.pl"
  COMMAND run_test.pl
)
