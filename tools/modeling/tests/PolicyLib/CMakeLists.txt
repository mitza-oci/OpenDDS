
dds_add_model_lib(PolicyLib)

ace_add_exe(PolicyLib_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model PolicyLib
)
ace_target_cxx_sources(PolicyLib_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(PolicyLib_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model PolicyLib
)
ace_target_cxx_sources(PolicyLib_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/PolicyLib/run_test.pl"
  COMMAND run_test.pl
)
