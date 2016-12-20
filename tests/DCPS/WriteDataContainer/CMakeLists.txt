project(WriteDataContainer CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(WriteDataContainer
  OUTPUT_NAME WriteDataContainerTest
  SOURCE_FILES WriteDataContainerTest.cpp
  FOLDER tests/DCPS/WriteDataContainer
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS WriteDataContainer
  TAO_IDL_FLAGS -SS
  IDL_FILES Simple.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/WriteDataContainer/run_test.pl"
  COMMAND run_test.pl
)
