
dds_add_model_lib(ExternalPolicies)

ace_add_exe(ExternalPolicies_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model ExternalPolicies
)
target_sources(ExternalPolicies_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(ExternalPolicies_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model ExternalPolicies
)
target_sources(ExternalPolicies_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/ExternalPolicies/run_test.pl"
  COMMAND run_test.pl
)
