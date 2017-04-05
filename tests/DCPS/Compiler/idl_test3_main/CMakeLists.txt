ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(idl_test3_main
  OUTPUT_NAME idl_test3

  LINK_LIBRARIES idl_test3_lib
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(idl_test3_main
  SOURCE_FILES main.cpp
)
ace_target_cxx_sources(idl_test3_main
  SOURCE_FILES main.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Compiler/idl_test3_main/run_test.pl"
  COMMAND run_test.pl
)
