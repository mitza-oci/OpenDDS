
dds_add_model_lib(MessengerNoPub)

ace_add_exe(MessengerNoPub_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerNoPub
)
target_sources(MessengerNoPub_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerNoPub/run_test.pl"
  COMMAND run_test.pl
)
