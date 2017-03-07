
dds_add_model_lib(Comments)

ace_add_exe(Comments_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Comments
)
target_sources(Comments_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(Comments_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Comments
)
target_sources(Comments_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Comments/run_test.pl"
  COMMAND run_test.pl
)
