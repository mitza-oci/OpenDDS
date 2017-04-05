
dds_add_model_lib(MessengerNoSub)

ace_add_exe(MessengerNoSub_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model MessengerNoSub

)
ace_target_cxx_sources(MessengerNoSub_xmlPublisher
  SOURCE_FILES publisher.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/MessengerNoSub/run_test.pl"
  COMMAND run_test.pl
)
