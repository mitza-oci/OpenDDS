
dds_add_model_lib(MessengerPubQos)

ace_add_exe(MessengerPubQos_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerPubQos

)
ace_target_cxx_sources(MessengerPubQos_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(MessengerPubQos_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerPubQos

)
ace_target_cxx_sources(MessengerPubQos_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerPubQos/run_test.pl"
  COMMAND run_test.pl
)
