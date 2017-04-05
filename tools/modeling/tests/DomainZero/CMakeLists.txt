
dds_add_model_lib(DomainZero)

ace_add_exe(DomainZero_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model DomainZero

)
ace_target_cxx_sources(DomainZero_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(DomainZero_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model DomainZero

)
ace_target_cxx_sources(DomainZero_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/DomainZero/run_test.pl"
  COMMAND run_test.pl
)
