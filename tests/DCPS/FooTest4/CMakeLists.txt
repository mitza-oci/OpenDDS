ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE OPENDDS_HAS_OBJECT_MODEL_PROFILE)

ace_add_exe(DcpsFooTest4
  OUTPUT_NAME FooTest4
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DcpsFooTest4
  SOURCE_FILES Reader.cpp
               Writer.cpp
               main.cpp
  HEADER_FILES Reader.h
               Writer.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FooTest4/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)


dds_add_test("tests/DCPS/FooTest4/run_test.pl mi"
  COMMAND run_test.pl mi
)


dds_add_test("tests/DCPS/FooTest4/run_test.pl mr"
  COMMAND run_test.pl mr
)


dds_add_test("tests/DCPS/FooTest4/run_test.pl mri"
  COMMAND run_test.pl mri
)


dds_add_test("tests/DCPS/FooTest4/run_test.pl mrit"
  COMMAND run_test.pl mrit
)
