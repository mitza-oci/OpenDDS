ace_requires(BUILT_IN_TOPICS)

add_jar(builtintopics_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES BuiltinTopicsTest.java
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/builtintopics/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)
