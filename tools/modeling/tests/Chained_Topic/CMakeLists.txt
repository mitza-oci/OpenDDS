
dds_add_model_lib(Chained_Topic
  PUBLIC_LINK_LIBRARIES MessengerMixed Chained_Data
)

ace_add_exe(Chained_Topic_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Chained_Topic
)
target_sources(Chained_Topic_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(Chained_Topic_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Chained_Topic
)
target_sources(Chained_Topic_xmlSubscriber PRIVATE
  subscriber.cpp
)

# dds_configure_test_files()
#
# dds_add_test("tools/modeling/tests/Chained_Topic/run_test.pl"
#   COMMAND run_test.pl
# )
