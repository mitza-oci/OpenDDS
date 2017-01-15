project(FaceUnitTests CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(BUILT_IN_TOPICS)

ace_add_lib(FaceUnitTests_Qossettings
  OUTPUT_NAME FaceUnitTests_Qossettings
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Qossettings
  SOURCE_FILES QosSettingsTest.cpp
)


ace_add_lib(FaceUnitTests_Memorypool
  OUTPUT_NAME FaceUnitTests_Memorypool
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Memorypool
  SOURCE_FILES MemoryPoolTest.cpp
)


ace_add_lib(FaceUnitTests_Freeindex
  OUTPUT_NAME FaceUnitTests_Freeindex
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Freeindex
  SOURCE_FILES FreeIndexTest.cpp
)


ace_add_lib(FaceUnitTests_Safetyprofilepool
  OUTPUT_NAME FaceUnitTests_Safetyprofilepool
  REQUIRES "NOT NO_OPENDDS_SAFETY_PROFILE"
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Safetyprofilepool
  SOURCE_FILES SafetyProfilePoolTest.cpp
)


ace_add_lib(FaceUnitTests_Sequences
  OUTPUT_NAME FaceUnitTests_Sequences
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
ace_target_cxx_sources(FaceUnitTests_Sequences
  SOURCE_FILES SequencesTest.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Unit/run_test.pl qossettings"
  COMMAND run_test.pl qossettings
)


dds_add_test("tests/FACE/Unit/run_test.pl memorypool"
  COMMAND run_test.pl memorypool
)


dds_add_test("tests/FACE/Unit/run_test.pl safetyprofilepool"
  COMMAND run_test.pl safetyprofilepool
  REQUIRES "NOT NO_OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/FACE/Unit/run_test.pl freeindex"
  COMMAND run_test.pl freeindex
)


dds_add_test("tests/FACE/Unit/run_test.pl sequences"
  COMMAND run_test.pl sequences
  REQUIRES "NOT NO_OPENDDS_SAFETY_PROFILE"
)
