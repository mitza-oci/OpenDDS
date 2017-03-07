
dds_add_model_lib(Codegen)

ace_add_exe(Codegen_pub
  OUTPUT_NAME aPublisher
  LINK_LIBRARIES OpenDDS_Model Codegen
)
target_sources(Codegen_pub PRIVATE
  aPublisher.cpp
)

ace_add_exe(Codegen_sub
  OUTPUT_NAME aSubscriber
  LINK_LIBRARIES OpenDDS_Model Codegen
)
target_sources(Codegen_sub PRIVATE
  aSubscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/Codegen/run_test.pl"
  COMMAND run_test.pl
)
