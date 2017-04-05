dds_add_jar(transport_config
  INCLUDE_JARS OpenDDS_DCPS_jar
  SOURCES TransportConfigTest.java
)


include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/transport_config/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)
