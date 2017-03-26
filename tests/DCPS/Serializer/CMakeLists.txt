project(Serializer CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(SerializerTest
  OUTPUT_NAME SerializerTest
  FOLDER tests/DCPS/Serializer
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(SerializerTest
  SOURCE_FILES AlignmentTest.cpp
               SerializerTest.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Serializer/run_test.pl"
  COMMAND run_test.pl
)
