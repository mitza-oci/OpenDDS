ace_requires(OPENDDS_HAS_BUILT_IN_TOPICS)

ace_add_exe(FACE_idl_test1_main
  OUTPUT_NAME idl_test1

  LINK_LIBRARIES FACE_idl_test1_lib
                 OpenDDS_FACE
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(FACE_idl_test1_main
  SOURCE_FILES main.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Compiler/idl_test1_main/run_test.pl"
  COMMAND run_test.pl
  LABELS FACE
)
