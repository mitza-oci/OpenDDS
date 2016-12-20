requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(idl_test3_main
  OUTPUT_NAME idl_test3
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/Compiler/idl_test3_main
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 idl_test3_lib
                 OpenDDS_Dcps
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/Compiler/idl_test3_main/run_test.pl"
  COMMAND run_test.pl
)
