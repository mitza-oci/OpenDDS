add_ace_exe(register_instance_Topic
  OUTPUT_NAME register_instance_test
  FOLDER tests/DCPS/RegisterInstance
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES DcpsFooType
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(register_instance_Topic
  SOURCE_FILES register_instance.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/RegisterInstance/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
