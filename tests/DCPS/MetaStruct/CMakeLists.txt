project(MetaStructTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

ace_requires(OPENDDS_HAS_CONTENT_SUBSCRIPTION_CORE
             OPENDDS_HAS_CONTENT_SUBSCRIPTION
             OPENDDS_HAS_MULTI_TOPIC
)

ace_add_exe(MetaStructTest
  OUTPUT_NAME MetaStructTest
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(MetaStructTest
  SOURCE_FILES MetaStructTest.cpp
)

dds_idl_sources(
  TARGETS MetaStructTest
  IDL_FILES MetaStructTest.idl
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/MetaStruct/run_test.pl"
  COMMAND run_test.pl
)
