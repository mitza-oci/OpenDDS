
dds_add_model_lib(ReusedData)
dds_add_model_lib(ReusedExtTypes
  PUBLIC_LINK_LIBRARIES ReusedData
)

ace_add_exe(ReusedExtTypes_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model ReusedExtTypes

)
ace_target_cxx_sources(ReusedExtTypes_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(ReusedExtTypes_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model ReusedExtTypes

)
ace_target_cxx_sources(ReusedExtTypes_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/ReusedExtTypes/run_test.pl"
  COMMAND run_test.pl
)
