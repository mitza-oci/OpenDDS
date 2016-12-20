project(ViewState CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE)

add_ace_exe(ViewState
  OUTPUT_NAME main
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/ViewState
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
add_dds_idl_files(
  TARGETS ViewState
  TAO_IDL_FLAGS -SS
  IDL_FILES Simple.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/ViewState/run_test.pl"
  COMMAND run_test.pl
)
