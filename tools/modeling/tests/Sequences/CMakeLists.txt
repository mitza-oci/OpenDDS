
dds_add_model_lib(Sequences)

ace_add_exe(Sequences_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Sequences
)
target_sources(Sequences_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(Sequences_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Sequences
)
target_sources(Sequences_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Sequences/run_test.pl"
  COMMAND run_test.pl
)
