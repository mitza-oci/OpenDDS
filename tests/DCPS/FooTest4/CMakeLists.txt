requires(OWNERSHIP_PROFILE OBJECT_MODEL_PROFILE)

add_ace_exe(DcpsFooTest4
  OUTPUT_NAME FooTest4
  FOLDER tests/DCPS/FooTest4
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(DcpsFooTest4
  SOURCE_FILES Reader.cpp
               Writer.cpp
               main.cpp
  HEADER_FILES Reader.h
               Writer.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/FooTest4/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/FooTest4/run_test.pl mi"
  COMMAND run_test.pl mi
)


add_dds_test("tests/DCPS/FooTest4/run_test.pl mr"
  COMMAND run_test.pl mr
)


add_dds_test("tests/DCPS/FooTest4/run_test.pl mri"
  COMMAND run_test.pl mri
)


add_dds_test("tests/DCPS/FooTest4/run_test.pl mrit"
  COMMAND run_test.pl mrit
)
