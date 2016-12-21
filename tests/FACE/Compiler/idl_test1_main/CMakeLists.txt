requires(BUILT_IN_TOPICS)

add_ace_exe(FACE_idl_test1_main
  OUTPUT_NAME idl_test1
  SOURCE_FILES main.cpp
  FOLDER tests/FACE/Compiler/idl_test1_main
  LINK_LIBRARIES FACE_idl_test1_lib
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_FACE
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/FACE/Compiler/idl_test1_main/run_test.pl"
  COMMAND run_test.pl
)
