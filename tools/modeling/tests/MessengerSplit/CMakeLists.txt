dds_add_model_lib(MessengerTypes)
dds_add_model_lib(MessengerTopics
  PUBLIC_LINK_LIBRARIES MessengerTypes
)
dds_add_model_lib(MessengerSplit
  PUBLIC_LINK_LIBRARIES MessengerTopics
)


ace_add_exe(MessengerSplit_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerSplit

)
ace_target_cxx_sources(MessengerSplit_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(MessengerSplit_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerSplit

)
ace_target_cxx_sources(MessengerSplit_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerSplit/run_test.pl"
  COMMAND run_test.pl
)
