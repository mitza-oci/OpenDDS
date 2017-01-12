project(Serializer CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(SerializerTest
  OUTPUT_NAME SerializerTest
  FOLDER tests/DCPS/Serializer
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(SerializerTest
  SOURCE_FILES AlignmentTest.cpp
               SerializerTest.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Serializer/run_test.pl"
  COMMAND run_test.pl
)
