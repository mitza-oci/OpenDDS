requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(idl_test1_main
  OUTPUT_NAME idl_test1
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/Compiler/idl_test1_main
  LINK_LIBRARIES idl_test1_lib
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Compiler/idl_test1_main/run_test.pl"
  COMMAND run_test.pl
)
