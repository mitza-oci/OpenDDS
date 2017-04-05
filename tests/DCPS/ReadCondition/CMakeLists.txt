project(ReadCondition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(ReadCondition
  OUTPUT_NAME ReadConditionTest

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ReadCondition
  SOURCE_FILES ReadConditionTest.cpp
)

dds_idl_sources(
  TARGETS ReadCondition
  TAO_IDL_FLAGS -SS -o GeneratedCode
  DDS_IDL_FLAGS -o GeneratedCode
  IDL_FILES Messenger.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ReadCondition/run_test.pl"
  COMMAND run_test.pl
)
