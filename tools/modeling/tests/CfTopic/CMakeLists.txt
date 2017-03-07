
dds_add_model_lib(CfTopic
  PUBLIC_LINK_LIBRARIES MessengerMixed
)

ace_add_exe(CfTopic_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model CfTopic
)
target_sources(CfTopic_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(CfTopic_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model CfTopic
)
target_sources(CfTopic_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/CfTopic/run_test.pl"
  COMMAND run_test.pl
)
