
dds_add_model_lib(MessengerMulti)

ace_add_exe(MessengerMulti_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerMulti
)
target_sources(MessengerMulti_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(MessengerMulti_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerMulti
)
target_sources(MessengerMulti_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerMulti/run_test.pl"
  COMMAND run_test.pl
)
