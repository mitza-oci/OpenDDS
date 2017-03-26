add_jar(subscriber_idl_test
  INCLUDE_JARS ${OPENDDS_JARS} messenger_idl_jar
  SOURCES DataReaderListenerImpl.java
         TestSubscriber.java
)

set_target_properties(subscriber_idl_test PROPERTIES
  FOLDER java/tests/messenger/subscriber
)


include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/messenger/subscriber/run_test.pl tcp"
  COMMAND run_test.pl tcp
  LABELS DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/subscriber/run_test.pl udp"
  COMMAND run_test.pl udp
  LABELS DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/subscriber/run_test.pl multicast"
  COMMAND run_test.pl multicast
  LABELS MCAST DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/subscriber/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS MCAST RTPS DCPS_MIN JAVA
  RESOURCE_LOCK JAVA_MESSENGER_RTPS
)


dds_add_test("java/tests/messenger/subscriber/run_test.pl rtps_uni"
  COMMAND run_test.pl rtps_uni
  LABELS RTPS DCPS_MIN JAVA
  RESOURCE_LOCK JAVA_MESSENGER_RTPS_UNI
)


dds_add_test("java/tests/messenger/subscriber/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES OPENDDS_HAS_BUILT_IN_TOPICS
  LABELS MCAST RTPS DCPS_MIN JAVA
  RESOURCE_LOCK JAVA_MESSENGER_RTPS_DISC
)


dds_add_test("java/tests/messenger/subscriber/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES OPENDDS_HAS_BUILT_IN_TOPICS
  LABELS MCAST RTPS DCPS_MIN JAVA
  RESOURCE_LOCK JAVA_MESSENGER_RTPS_TCP
)
