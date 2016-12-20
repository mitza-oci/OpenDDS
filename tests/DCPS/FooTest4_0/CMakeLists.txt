requires(OWNERSHIP_PROFILE)

add_ace_exe(DcpsFooTest4_0
  OUTPUT_NAME FooTest4_0
  SOURCE_FILES DataReaderListener.cpp
               Reader.cpp
               Writer.cpp
               main.cpp
  HEADER_FILES DataReaderListener.h
               Reader.h
               Writer.h
  FOLDER tests/DCPS/FooTest4_0
  LINK_LIBRARIES DcpsFooType4
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 common
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/FooTest4_0/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)
