
dds_add_model_lib(UDP)

ace_add_exe(UDP_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model UDP
)
target_sources(UDP_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(UDP_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model UDP
)
target_sources(UDP_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/UDP/run_test.pl"
  COMMAND run_test.pl
)
