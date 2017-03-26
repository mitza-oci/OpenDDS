project(QueryCondition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_QUERY_CONDITION OPENDDS_HAS_CONTENT_SUBSCRIPTION)

ace_add_exe(QueryCondition
  OUTPUT_NAME QueryConditionTest
  FOLDER tests/DCPS/QueryCondition
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(QueryCondition
  SOURCE_FILES QueryConditionTest.cpp
)

dds_idl_sources(
  TARGETS QueryCondition
  IDL_FILES Messenger.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/QueryCondition/run_test.pl"
  COMMAND run_test.pl
)
