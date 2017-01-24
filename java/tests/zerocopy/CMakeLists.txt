add_jar(zerocopy_java_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES ZeroCopy.java
)