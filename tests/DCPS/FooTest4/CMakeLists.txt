requires(OWNERSHIP_PROFILE OBJECT_MODEL_PROFILE)

add_ace_exe(DcpsFooTest4
  OUTPUT_NAME FooTest4
  SOURCE_FILES main.cpp
               Reader.cpp
               Writer.cpp
  HEADER_FILES Reader.h
               Writer.h
  FOLDER tests/DCPS/FooTest4
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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
