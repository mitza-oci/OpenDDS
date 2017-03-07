
dds_add_model_lib(MultiTopic)

ace_add_exe(MultiTopic_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MultiTopic
)
target_sources(MultiTopic_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(MultiTopic_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MultiTopic
)
target_sources(MultiTopic_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MultiTopic/run_test.pl"
  COMMAND run_test.pl
)
