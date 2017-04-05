dds_add_model_lib(MessengerTypesMixed)
dds_add_model_lib(MessengerMixed
  PUBLIC_LINK_LIBRARIES MessengerTypesMixed
)


ace_add_exe(MessengerMixed_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerMixed

)
ace_target_cxx_sources(MessengerMixed_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(MessengerMixed_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model MessengerMixed

)
ace_target_cxx_sources(MessengerMixed_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerMixed/run_test.pl"
  COMMAND run_test.pl
)
