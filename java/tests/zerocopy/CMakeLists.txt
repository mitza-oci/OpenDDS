dds_add_jar(zerocopy_java_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES ZeroCopy.java
)


include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/zerocopy/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)
