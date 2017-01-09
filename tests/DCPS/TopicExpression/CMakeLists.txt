project(TopicExpressionTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(MULTI_TOPIC CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION)

add_ace_exe(TopicExpressionTest
  OUTPUT_NAME TopicExpressionTest
  FOLDER tests/DCPS/TopicExpression
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(TopicExpressionTest
  SOURCE_FILES TopicExpression.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/TopicExpression/run_test.pl"
  COMMAND run_test.pl
)
