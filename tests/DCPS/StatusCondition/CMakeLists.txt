project(StatusCondition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_PERSISTENCE_PROFILE)

ace_add_exe(StatusCondition
  OUTPUT_NAME StatusConditionTest
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(StatusCondition
  SOURCE_FILES StatusConditionTest.cpp
)

dds_idl_sources(
  TARGETS StatusCondition
  TAO_IDL_FLAGS -SS
  IDL_FILES Messenger.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/StatusCondition/run_test.pl"
  COMMAND run_test.pl
)
