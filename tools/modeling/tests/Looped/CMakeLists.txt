
dds_add_model_lib(Looped)

ace_add_exe(Looped_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Looped

)
ace_target_cxx_sources(Looped_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(Looped_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Looped

)
ace_target_cxx_sources(Looped_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Looped/run_test.pl"
  COMMAND run_test.pl
)
