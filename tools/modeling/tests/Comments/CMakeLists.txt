
dds_add_model_lib(Comments)

ace_add_exe(Comments_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Comments

)
ace_target_cxx_sources(Comments_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(Comments_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Comments

)
ace_target_cxx_sources(Comments_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Comments/run_test.pl"
  COMMAND run_test.pl
)
