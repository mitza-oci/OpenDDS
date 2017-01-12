project(QueryCondition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(QUERY_CONDITION CONTENT_SUBSCRIPTION)

ace_add_exe(QueryCondition
  OUTPUT_NAME QueryConditionTest
  FOLDER tests/DCPS/QueryCondition
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
)
ace_target_cxx_sources(QueryCondition
  SOURCE_FILES QueryConditionTest.cpp
)

dds_idl_sources(
  TARGETS QueryCondition
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/QueryCondition/run_test.pl"
  COMMAND run_test.pl
)
