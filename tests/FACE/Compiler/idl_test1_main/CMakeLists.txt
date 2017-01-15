ace_requires(BUILT_IN_TOPICS)

ace_add_exe(FACE_idl_test1_main
  OUTPUT_NAME idl_test1
  FOLDER tests/FACE/Compiler/idl_test1_main
  LINK_LIBRARIES FACE_idl_test1_lib
                 OpenDDS_FACE
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(FACE_idl_test1_main
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/FACE/Compiler/idl_test1_main/run_test.pl"
  COMMAND run_test.pl
)
