project(QueryCondition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(QUERY_CONDITION CONTENT_SUBSCRIPTION)

add_ace_exe(QueryCondition
  OUTPUT_NAME QueryConditionTest
  SOURCE_FILES QueryConditionTest.cpp
  FOLDER tests/DCPS/QueryCondition
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)
add_dds_idl_files(
  TARGETS QueryCondition
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/QueryCondition/run_test.pl"
  COMMAND run_test.pl
)
