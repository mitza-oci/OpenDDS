
dds_add_model_lib(Exchange)

ace_add_exe(Exchange_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Exchange

)
ace_target_cxx_sources(Exchange_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(Exchange_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Exchange

)
ace_target_cxx_sources(Exchange_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Exchange/run_test.pl"
  COMMAND run_test.pl
)
