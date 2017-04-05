
dds_add_model_lib(CfTopic
  PUBLIC_LINK_LIBRARIES MessengerMixed
)

ace_add_exe(CfTopic_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model CfTopic

)
ace_target_cxx_sources(CfTopic_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(CfTopic_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model CfTopic

)
ace_target_cxx_sources(CfTopic_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/CfTopic/run_test.pl"
  COMMAND run_test.pl
)
