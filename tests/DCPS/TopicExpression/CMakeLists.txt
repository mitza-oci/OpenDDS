project(TopicExpressionTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(MULTI_TOPIC CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION)

add_ace_exe(TopicExpressionTest
  OUTPUT_NAME TopicExpressionTest
  SOURCE_FILES TopicExpression.cpp
  FOLDER tests/DCPS/TopicExpression
  LINK_LIBRARIES OpenDDS_Dcps
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/TopicExpression/run_test.pl"
  COMMAND run_test.pl
)
