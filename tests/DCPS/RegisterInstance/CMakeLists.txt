add_ace_exe(register_instance_topic
  OUTPUT_NAME register_instance_test
  SOURCE_FILES register_instance.cpp
  FOLDER tests/DCPS/RegisterInstance
  LINK_LIBRARIES DcpsFooType
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/RegisterInstance/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
