add_jar(java_both_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES Both.java
)
set_target_properties(java_both_test PROPERTIES
  FOLDER java/tests/messenger/both
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/messenger/both/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)
