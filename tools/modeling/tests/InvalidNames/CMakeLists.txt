
dds_add_model_lib(InvalidNames)

ace_add_exe(InvalidNames_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model InvalidNames
)
target_sources(InvalidNames_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(InvalidNames_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model InvalidNames
)
target_sources(InvalidNames_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/InvalidNames/run_test.pl"
  COMMAND run_test.pl
)
