project(GuardCondition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(GuardCondition
  OUTPUT_NAME GuardConditionTest
  FOLDER tests/DCPS/GuardCondition
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(GuardCondition
  SOURCE_FILES GuardConditionTest.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/GuardCondition/run_test.pl"
  COMMAND run_test.pl
)
