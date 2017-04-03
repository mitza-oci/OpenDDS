ace_requires(OPENDDS_HAS_BUILT_IN_TOPICS)

dds_add_model_lib(RemoteInstHandles)

ace_add_exe(RemoteInstHandles_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model RemoteInstHandles
)
ace_target_cxx_sources(RemoteInstHandles_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(RemoteInstHandles_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model RemoteInstHandles
)
ace_target_cxx_sources(RemoteInstHandles_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/RemoteInstHandles/run_test.pl"
  COMMAND run_test.pl
)
