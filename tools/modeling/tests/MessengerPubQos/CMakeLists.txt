
dds_add_model_lib(MessengerPubQos)

ace_add_exe(MessengerPubQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerPubQos
)
target_sources(MessengerPubQos_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(MessengerPubQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerPubQos
)
target_sources(MessengerPubQos_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerPubQos/run_test.pl"
  COMMAND run_test.pl
)
