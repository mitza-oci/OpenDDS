project(QueryCondition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(QUERY_CONDITION CONTENT_SUBSCRIPTION)

add_ace_exe(QueryCondition
  OUTPUT_NAME QueryConditionTest
  FOLDER tests/DCPS/QueryCondition
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
)
target_cxx_sources(QueryCondition
  SOURCE_FILES QueryConditionTest.cpp
)

dds_idl_sources(
  TARGETS QueryCondition
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/QueryCondition/run_test.pl"
  COMMAND run_test.pl
)
