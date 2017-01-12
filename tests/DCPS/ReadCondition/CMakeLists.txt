project(ReadCondition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(ReadCondition
  OUTPUT_NAME ReadConditionTest
  FOLDER tests/DCPS/ReadCondition
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(ReadCondition
  SOURCE_FILES ReadConditionTest.cpp
)

dds_idl_sources(
  TARGETS ReadCondition
  TAO_IDL_FLAGS -SS
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ReadCondition/run_test.pl"
  COMMAND run_test.pl
)
