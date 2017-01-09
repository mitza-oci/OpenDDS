requires(BUILT_IN_TOPICS)

add_ace_exe(FACE_idl_test1_main
  OUTPUT_NAME idl_test1
  FOLDER tests/FACE/Compiler/idl_test1_main
  ASPECTS DCPS_DEFAULT_DISCOVERY
          FACE
  LINK_LIBRARIES FACE_idl_test1_lib
                 OpenDDS_Dcps
)
target_cxx_sources(FACE_idl_test1_main
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Compiler/idl_test1_main/run_test.pl"
  COMMAND run_test.pl
)
