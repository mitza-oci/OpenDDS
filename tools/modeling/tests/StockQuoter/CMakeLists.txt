
dds_add_model_lib(StockQuoter)

ace_add_exe(StockQuoter_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model StockQuoter
)
target_sources(StockQuoter_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(StockQuoter_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model StockQuoter
)
target_sources(StockQuoter_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/StockQuoter/run_test.pl"
  COMMAND run_test.pl
)
