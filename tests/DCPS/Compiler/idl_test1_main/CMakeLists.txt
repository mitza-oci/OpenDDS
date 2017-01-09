requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(idl_test1_main
  OUTPUT_NAME idl_test1
  FOLDER tests/DCPS/Compiler/idl_test1_main
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES idl_test1_lib
                 OpenDDS_Dcps
)
target_cxx_sources(idl_test1_main
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Compiler/idl_test1_main/run_test.pl"
  COMMAND run_test.pl
)
