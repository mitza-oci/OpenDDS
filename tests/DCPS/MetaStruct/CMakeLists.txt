project(MetaStructTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION)

add_ace_lib(MetaStructTest
  OUTPUT_NAME MetaStructTest
  FOLDER tests/DCPS/MetaStruct
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(MetaStructTest
  SOURCE_FILES MetaStructTest.cpp
)

dds_idl_sources(
  TARGETS MetaStructTest
  IDL_FILES MetaStructTest.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/MetaStruct/run_test.pl"
  COMMAND run_test.pl
)
