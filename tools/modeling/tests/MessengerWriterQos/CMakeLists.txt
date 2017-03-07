
dds_add_model_lib(MessengerWriterQos)

ace_add_exe(MessengerWriterQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerWriterQos
)
target_sources(MessengerWriterQos_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(MessengerWriterQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerWriterQos
)
target_sources(MessengerWriterQos_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerWriterQos/run_test.pl"
  COMMAND run_test.pl
)
