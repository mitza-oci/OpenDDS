ace_add_exe(register_instance_Topic
  OUTPUT_NAME register_instance_test
  LINK_LIBRARIES DcpsFooType
                 OpenDDS_Rtps_Udp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(register_instance_Topic
  SOURCE_FILES register_instance.cpp
)
ace_target_cxx_sources(register_instance_Topic
  SOURCE_FILES register_instance.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/RegisterInstance/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
