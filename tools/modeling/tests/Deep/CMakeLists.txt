
dds_add_model_lib(*)

ace_add_exe(Deep_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Deep
)
ace_target_cxx_sources(Deep_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(Deep_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Deep
)
ace_target_cxx_sources(Deep_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Deep/run_test.pl"
  COMMAND run_test.pl
)
