
dds_add_model_lib(MultiDCPS)

ace_add_exe(MultiDCPS_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MultiDCPS

)
ace_target_cxx_sources(MultiDCPS_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(MultiDCPS_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MultiDCPS

)
ace_target_cxx_sources(MultiDCPS_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MultiDCPS/run_test.pl"
  COMMAND run_test.pl
)
