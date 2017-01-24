add_jar(subscriber_idl_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES DataReaderListenerImpl.java
         TestSubscriber.java
)