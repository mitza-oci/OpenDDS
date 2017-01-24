add_jar(publisher_idl_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES TestPublisher.java
)