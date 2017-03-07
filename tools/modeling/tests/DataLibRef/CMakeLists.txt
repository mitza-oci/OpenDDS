
dds_add_model_lib(DataLibRef)

ace_add_exe(DataLibRef_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model DataLibRef
)
target_sources(DataLibRef_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(DataLibRef_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model DataLibRef
)
target_sources(DataLibRef_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/DataLibRef/run_test.pl"
  COMMAND run_test.pl
)
