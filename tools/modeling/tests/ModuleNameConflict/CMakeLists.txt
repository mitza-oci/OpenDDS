
dds_add_model_lib(ModuleNameConflict
  PUBLIC_LINK_LIBRARIES MessengerTypesMixed
)

ace_add_exe(ModuleNameConflict_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model ModuleNameConflict
)
target_sources(ModuleNameConflict_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(ModuleNameConflict_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model ModuleNameConflict
)
target_sources(ModuleNameConflict_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/ModuleNameConflict/run_test.pl"
  COMMAND run_test.pl
)
