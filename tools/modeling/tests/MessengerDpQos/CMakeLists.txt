
dds_add_model_lib(MessengerDpQos)

ace_add_exe(MessengerDpQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerDpQos

)
ace_target_cxx_sources(MessengerDpQos_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(MessengerDpQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerDpQos

)
ace_target_cxx_sources(MessengerDpQos_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerDpQos/run_test.pl"
  COMMAND run_test.pl
)
