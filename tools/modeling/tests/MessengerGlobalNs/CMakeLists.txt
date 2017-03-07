
dds_add_model_lib(MessengerGlobalNs)

ace_add_exe(MessengerGlobalNs_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerGlobalNs
)
target_sources(MessengerGlobalNs_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(MessengerGlobalNs_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerGlobalNs
)
target_sources(MessengerGlobalNs_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerGlobalNs/run_test.pl"
  COMMAND run_test.pl
)
