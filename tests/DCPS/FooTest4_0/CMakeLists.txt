requires(OWNERSHIP_PROFILE)

add_ace_exe(DcpsFooTest4_0
  OUTPUT_NAME FooTest4_0
  FOLDER tests/DCPS/FooTest4_0
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType4
                 common
                 OpenDDS_Dcps
)
target_cxx_sources(DcpsFooTest4_0
  SOURCE_FILES DataReaderListener.cpp
               Reader.cpp
               Writer.cpp
               main.cpp
  HEADER_FILES DataReaderListener.h
               Reader.h
               Writer.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/FooTest4_0/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)
