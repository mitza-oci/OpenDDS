project(FilterExpressionTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_CONTENT_SUBSCRIPTION_CORE OPENDDS_HAS_CONTENT_SUBSCRIPTION)

ace_add_exe(FilterExpressionTest
  OUTPUT_NAME FilterExpressionTest

  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(FilterExpressionTest
  SOURCE_FILES FilterExpression.cpp
)

dds_idl_sources(
  TARGETS FilterExpressionTest
  IDL_FILES FilterStruct.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FilterExpression/run_test.pl"
  COMMAND run_test.pl
)
