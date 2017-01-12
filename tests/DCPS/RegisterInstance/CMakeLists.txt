ace_add_exe(register_instance_Topic
  OUTPUT_NAME register_instance_test
  FOLDER tests/DCPS/RegisterInstance
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES DcpsFooType
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(register_instance_Topic
  SOURCE_FILES register_instance.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/RegisterInstance/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
