project(Serializer CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(SerializerTest
  OUTPUT_NAME SerializerTest
  FOLDER tests/DCPS/Serializer
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(SerializerTest
  SOURCE_FILES AlignmentTest.cpp
               SerializerTest.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Serializer/run_test.pl"
  COMMAND run_test.pl
)
