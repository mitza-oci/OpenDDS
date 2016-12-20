project(Serializer CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(SerializerTest
  OUTPUT_NAME SerializerTest
  SOURCE_FILES AlignmentTest.cpp
               SerializerTest.cpp
  FOLDER tests/DCPS/Serializer
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/Serializer/run_test.pl"
  COMMAND run_test.pl
)
