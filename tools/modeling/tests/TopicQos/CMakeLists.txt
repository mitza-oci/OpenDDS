
dds_add_model_lib(TopQos)

ace_add_exe(TopicQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model TopQos
)
target_sources(TopicQos_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(TopicQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model TopQos
)
target_sources(TopicQos_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/TopicQos/run_test.pl"
  COMMAND run_test.pl
)
