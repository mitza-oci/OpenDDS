
dds_add_model_lib(CompositeKey)

ace_add_exe(CompositeKey_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model CompositeKey
)
ace_target_cxx_sources(CompositeKey_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(CompositeKey_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model CompositeKey
)
ace_target_cxx_sources(CompositeKey_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/CompositeKey/run_test.pl"
  COMMAND run_test.pl
)
