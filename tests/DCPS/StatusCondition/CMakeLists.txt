project(StatusCondition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(PERSISTENCE_PROFILE)

add_ace_exe(StatusCondition
  OUTPUT_NAME StatusConditionTest
  FOLDER tests/DCPS/StatusCondition
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(StatusCondition
  SOURCE_FILES StatusConditionTest.cpp
)

dds_idl_sources(
  TARGETS StatusCondition
  TAO_IDL_FLAGS -SS
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/StatusCondition/run_test.pl"
  COMMAND run_test.pl
)
