project(TopicExpressionTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(MULTI_TOPIC CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION)

ace_add_exe(TopicExpressionTest
  OUTPUT_NAME TopicExpressionTest
  FOLDER tests/DCPS/TopicExpression
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(TopicExpressionTest
  SOURCE_FILES TopicExpression.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/TopicExpression/run_test.pl"
  COMMAND run_test.pl
)
