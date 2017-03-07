
dds_add_model_lib(SubQos)

ace_add_exe(SubscriberQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model SubQos
)
target_sources(SubscriberQos_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(SubscriberQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model SubQos
)
target_sources(SubscriberQos_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/SubscriberQos/run_test.pl"
  COMMAND run_test.pl
)
