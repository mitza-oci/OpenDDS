project(FaceUnitTests CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("TARGET OpenDDS_FACE")

ace_add_exe(FaceUnitTests_Qossettings
  OUTPUT_NAME QosSettingsTest

  LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Qossettings
  SOURCE_FILES QosSettingsTest.cpp
)


ace_add_exe(FaceUnitTests_Memorypool
  OUTPUT_NAME MemoryPoolTest

  LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Memorypool
  SOURCE_FILES MemoryPoolTest.cpp
)


ace_add_exe(FaceUnitTests_Freeindex
  OUTPUT_NAME FreeIndexTest

  LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Freeindex
  SOURCE_FILES FreeIndexTest.cpp
)


ace_add_exe(FaceUnitTests_Safetyprofilepool
  OUTPUT_NAME SafetyProfilePoolTest
  REQUIRES OPENDDS_SAFETY_PROFILE

  LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Safetyprofilepool
  SOURCE_FILES SafetyProfilePoolTest.cpp
)


ace_add_exe(FaceUnitTests_Sequences
  OUTPUT_NAME SequencesTest

  LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Sequences
  SOURCE_FILES SequencesTest.cpp
)


include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Unit/run_test.pl qossettings"
  COMMAND run_test.pl qossettings
  LABELS FACE
)


dds_add_test("tests/FACE/Unit/run_test.pl memorypool"
  COMMAND run_test.pl memorypool
  LABELS FACE
)


dds_add_test("tests/FACE/Unit/run_test.pl safetyprofilepool"
  COMMAND run_test.pl safetyprofilepool
  REQUIRES OPENDDS_SAFETY_PROFILE
  LABELS FACE
)


dds_add_test("tests/FACE/Unit/run_test.pl freeindex"
  COMMAND run_test.pl freeindex
  LABELS FACE
)


dds_add_test("tests/FACE/Unit/run_test.pl sequences"
  COMMAND run_test.pl sequences
  REQUIRES OPENDDS_SAFETY_PROFILE
  LABELS FACE
)
