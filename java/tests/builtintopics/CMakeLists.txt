ace_requires(BUILT_IN_TOPICS)

add_jar(builtintopics_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES BuiltinTopicsTest.java
)

