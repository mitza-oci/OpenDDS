project(UnitTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(DdsDcps_UnitTest
  OUTPUT_NAME DdsDcps_UnitTest
  FOLDER tests/DCPS/unit
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(DdsDcps_UnitTest
  SOURCE_FILES Main.cpp
               MyTypeSupportImpl.cpp
  HEADER_FILES MyTypeSupportImpl.h
)

tao_idl_sources(
  TARGETS DdsDcps_UnitTest
  IDL_FILES MyTypeSupport.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/unit/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)
