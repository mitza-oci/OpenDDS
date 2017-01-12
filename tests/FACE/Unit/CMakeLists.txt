project(FaceUnitTests CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(BUILT_IN_TOPICS)

add_ace_lib(FaceUnitTests_Qossettings
  OUTPUT_NAME FaceUnitTests_Qossettings
  FOLDER tests/FACE/Unit
  ASPECTS FACE
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FaceUnitTests_Qossettings
  SOURCE_FILES QosSettingsTest.cpp
)


add_ace_lib(FaceUnitTests_Memorypool
  OUTPUT_NAME FaceUnitTests_Memorypool
  FOLDER tests/FACE/Unit
  ASPECTS FACE
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FaceUnitTests_Memorypool
  SOURCE_FILES MemoryPoolTest.cpp
)


add_ace_lib(FaceUnitTests_Freeindex
  OUTPUT_NAME FaceUnitTests_Freeindex
  FOLDER tests/FACE/Unit
  ASPECTS FACE
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FaceUnitTests_Freeindex
  SOURCE_FILES FreeIndexTest.cpp
)


add_ace_lib(FaceUnitTests_Safetyprofilepool
  OUTPUT_NAME FaceUnitTests_Safetyprofilepool
  REQUIRES "NOT NO_OPENDDS_SAFETY_PROFILE"
  FOLDER tests/FACE/Unit
  ASPECTS FACE
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FaceUnitTests_Safetyprofilepool
  SOURCE_FILES SafetyProfilePoolTest.cpp
)


add_ace_lib(FaceUnitTests_Sequences
  OUTPUT_NAME FaceUnitTests_Sequences
  FOLDER tests/FACE/Unit
  ASPECTS FACE
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FaceUnitTests_Sequences
  SOURCE_FILES SequencesTest.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Unit/run_test.pl qossettings"
  COMMAND run_test.pl qossettings
)


add_dds_test("tests/FACE/Unit/run_test.pl memorypool"
  COMMAND run_test.pl memorypool
)


add_dds_test("tests/FACE/Unit/run_test.pl safetyprofilepool"
  COMMAND run_test.pl safetyprofilepool
  REQUIRES "NOT NO_OPENDDS_SAFETY_PROFILE"
)


add_dds_test("tests/FACE/Unit/run_test.pl freeindex"
  COMMAND run_test.pl freeindex
)


add_dds_test("tests/FACE/Unit/run_test.pl sequences"
  COMMAND run_test.pl sequences
  REQUIRES "NOT NO_OPENDDS_SAFETY_PROFILE"
)
