
dds_add_model_lib(ELTypes)
dds_add_model_lib(EmptyLibs
  PUBLIC_LINK_LIBRARIES ELTypes
)

ace_add_exe(EmptyLibs_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model EmptyLibs

)
ace_target_cxx_sources(EmptyLibs_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(EmptyLibs_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model EmptyLibs

)
ace_target_cxx_sources(EmptyLibs_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/EmptyLibs/run_test.pl"
  COMMAND run_test.pl
)
