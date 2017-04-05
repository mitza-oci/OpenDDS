
dds_add_model_lib(MultiInstance)

ace_add_exe(MultiInstance_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MultiInstance

)
ace_target_cxx_sources(MultiInstance_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(MultiInstance_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MultiInstance

)
ace_target_cxx_sources(MultiInstance_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MultiInstance/run_test.pl"
  COMMAND run_test.pl
)
