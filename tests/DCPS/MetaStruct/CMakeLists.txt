project(MetaStructTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(CONTENT_SUBSCRIPTION_CORE CONTENT_SUBSCRIPTION MULTI_TOPIC)

ace_add_exe(MetaStructTest
  OUTPUT_NAME MetaStructTest
  FOLDER tests/DCPS/MetaStruct
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(MetaStructTest
  SOURCE_FILES MetaStructTest.cpp
)

dds_idl_sources(
  TARGETS MetaStructTest
  IDL_FILES MetaStructTest.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MetaStruct/run_test.pl"
  COMMAND run_test.pl
)
