project(UnitTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(DdsDcps_UnitTest
  OUTPUT_NAME DdsDcps_UnitTest
  SOURCE_FILES MyTypeSupportImpl.cpp
               Main.cpp
  HEADER_FILES MyTypeSupportImpl.h
  FOLDER tests/DCPS/unit
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
add_tao_idl_files(
  TARGETS DdsDcps_UnitTest
  IDL_FILES MyTypeSupport.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/unit/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)
