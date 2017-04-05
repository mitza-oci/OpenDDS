
dds_add_model_lib(Messenger)

ace_add_exe(Messenger_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Messenger

)
ace_target_cxx_sources(Messenger_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(Messenger_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Messenger

)
ace_target_cxx_sources(Messenger_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Messenger/run_test.pl"
  COMMAND run_test.pl
)
