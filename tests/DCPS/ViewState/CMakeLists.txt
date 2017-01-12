project(ViewState CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OWNERSHIP_PROFILE)

ace_add_exe(ViewState
  OUTPUT_NAME main
  FOLDER tests/DCPS/ViewState
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(ViewState
  SOURCE_FILES main.cpp
)

dds_idl_sources(
  TARGETS ViewState
  TAO_IDL_FLAGS -SS
  IDL_FILES Simple.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ViewState/run_test.pl"
  COMMAND run_test.pl
)
