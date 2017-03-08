
dds_add_model_lib(MessengerMC)

ace_add_exe(MessengerMC_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerMC
)
target_sources(MessengerMC_xmlPublisher PRIVATE
  publisher.cpp
  fs_signal.cpp
)

ace_add_exe(MessengerMC_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerMC
)
target_sources(MessengerMC_xmlSubscriber PRIVATE
  subscriber.cpp
  fs_signal.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerMC/run_test.pl"
  COMMAND run_test.pl
  LABELS MCAST
)
