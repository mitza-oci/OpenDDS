project(GuardCondition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(GuardCondition
  OUTPUT_NAME GuardConditionTest
  FOLDER tests/DCPS/GuardCondition
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(GuardCondition
  SOURCE_FILES GuardConditionTest.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/GuardCondition/run_test.pl"
  COMMAND run_test.pl
)
