project(WriteDataContainer CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(WriteDataContainer
  OUTPUT_NAME WriteDataContainerTest
  FOLDER tests/DCPS/WriteDataContainer
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(WriteDataContainer
  SOURCE_FILES WriteDataContainerTest.cpp
)

dds_idl_sources(
  TARGETS WriteDataContainer
  TAO_IDL_FLAGS -SS
  IDL_FILES Simple.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/WriteDataContainer/run_test.pl"
  COMMAND run_test.pl
)
