add_jar(transport_config
  INCLUDE_JARS OpenDDS_Dcps_jar
  SOURCES TransportConfigTest.java
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/transport_config/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)
