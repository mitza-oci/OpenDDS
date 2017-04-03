
dds_add_model_lib(ReusedTypes)

ace_add_exe(ReusedTypes_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model ReusedTypes
)
ace_target_cxx_sources(ReusedTypes_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(ReusedTypes_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model ReusedTypes
)
ace_target_cxx_sources(ReusedTypes_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/ReusedTypes/run_test.pl"
  COMMAND run_test.pl
)
