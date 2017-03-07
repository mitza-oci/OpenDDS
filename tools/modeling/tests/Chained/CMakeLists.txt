
ace_add_exe(Chained_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Chained_Topic
)
target_sources(Chained_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(Chained_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Chained_Topic
)
target_sources(Chained_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Chained/run_test.pl"
  COMMAND run_test.pl
)
