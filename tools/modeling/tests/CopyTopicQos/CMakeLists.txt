
dds_add_model_lib(CopyTopicQos)

ace_add_exe(CopyTopicQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model CopyTopicQos

)
ace_target_cxx_sources(CopyTopicQos_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(CopyTopicQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model CopyTopicQos

)
ace_target_cxx_sources(CopyTopicQos_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/CopyTopicQos/run_test.pl"
  COMMAND run_test.pl
)
