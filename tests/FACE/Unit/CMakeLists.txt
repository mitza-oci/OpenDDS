project(FaceUnitTests CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(BUILT_IN_TOPICS)

add_ace_lib(FaceUnitTests_QosSettings
  OUTPUT_NAME FaceUnitTests_QosSettings
  SOURCE_FILES QosSettingsTest.cpp
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)

add_ace_lib(FaceUnitTests_MemoryPool
  OUTPUT_NAME FaceUnitTests_MemoryPool
  SOURCE_FILES MemoryPoolTest.cpp
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)

add_ace_lib(FaceUnitTests_FreeIndex
  OUTPUT_NAME FaceUnitTests_FreeIndex
  SOURCE_FILES FreeIndexTest.cpp
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)

add_ace_lib(FaceUnitTests_SafetyProfilePool
  OUTPUT_NAME FaceUnitTests_SafetyProfilePool
  SOURCE_FILES SafetyProfilePoolTest.cpp
  REQUIRES "NOT NO_OPENDDS_SAFETY_PROFILE"
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)

add_ace_lib(FaceUnitTests_Sequences
  OUTPUT_NAME FaceUnitTests_Sequences
  SOURCE_FILES SequencesTest.cpp
  FOLDER tests/FACE/Unit
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
