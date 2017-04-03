
dds_add_model_lib(Arrays)

ace_add_exe(Arrays_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Arrays
)
ace_target_cxx_sources(Arrays_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(Arrays_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Arrays
)
ace_target_cxx_sources(Arrays_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Arrays/run_test.pl"
  COMMAND run_test.pl
)
