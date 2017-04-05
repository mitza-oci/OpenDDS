
dds_add_model_lib(DataLibRef)

ace_add_exe(DataLibRef_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model DataLibRef

)
ace_target_cxx_sources(DataLibRef_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(DataLibRef_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model DataLibRef

)
ace_target_cxx_sources(DataLibRef_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/DataLibRef/run_test.pl"
  COMMAND run_test.pl
)
