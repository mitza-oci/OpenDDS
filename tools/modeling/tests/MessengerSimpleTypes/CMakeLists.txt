
dds_add_model_lib(MessengerSimpleTypes)

ace_add_exe(MessengerSimpleTypes_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerSimpleTypes
)
target_sources(MessengerSimpleTypes_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(MessengerSimpleTypes_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerSimpleTypes
)
target_sources(MessengerSimpleTypes_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerSimpleTypes/run_test.pl"
  COMMAND run_test.pl
)
