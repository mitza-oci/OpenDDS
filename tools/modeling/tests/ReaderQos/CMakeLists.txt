
dds_add_model_lib(ReaderQos)

ace_add_exe(ReaderQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model ReaderQos
)
ace_target_cxx_sources(ReaderQos_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(ReaderQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model ReaderQos
)
ace_target_cxx_sources(ReaderQos_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/ReaderQos/run_test.pl"
  COMMAND run_test.pl
)
