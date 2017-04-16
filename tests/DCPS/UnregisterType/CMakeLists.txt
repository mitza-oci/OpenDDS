
project(UnregisterTypeTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_exe(UnregisterTypeTest
  OUTPUT_NAME unregister_type_test
  LINK_LIBRARIES OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(UnregisterTypeTest
  SOURCE_FILES unregister_type.cpp
)

dds_idl_sources(
  TARGETS UnregisterTypeTest
  TAO_IDL_FLAGS -SS
  IDL_FILES Test.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/UnregisterType/run_test.pl"
  COMMAND run_test.pl
)
