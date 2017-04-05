ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_exe(DcpsFooTest4_0
  OUTPUT_NAME FooTest4_0

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DcpsFooTest4_0
  SOURCE_FILES DataReaderListener.cpp
               Reader.cpp
               Writer.cpp
               main.cpp
  HEADER_FILES DataReaderListener.h
               Reader.h
               Writer.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FooTest4_0/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)
