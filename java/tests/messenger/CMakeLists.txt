add_subdirectory(messenger_idl)
add_subdirectory(both)
add_subdirectory(publisher)
add_subdirectory(subscriber)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/messenger/run_test.pl tcp"
  COMMAND run_test.pl tcp
  LABELS DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/run_test.pl udp"
  COMMAND run_test.pl udp
  LABELS DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/run_test.pl multicast"
  COMMAND run_test.pl multicast
  LABELS MCAST DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS MCAST RTPS DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/run_test.pl rtps_uni"
  COMMAND run_test.pl rtps_uni
  LABELS RTPS DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES OPENDDS_HAS_BUILT_IN_TOPICS
  LABELS MCAST RTPS DCPS_MIN JAVA
)


dds_add_test("java/tests/messenger/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES OPENDDS_HAS_BUILT_IN_TOPICS
  LABELS MCAST RTPS DCPS_MIN JAVA
)
