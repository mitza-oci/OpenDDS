
dds_add_model_lib(ReferExternalProj
  PUBLIC_LINK_LIBRARIES MessengerMixed
)

ace_add_exe(ReferExternalProj_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model ReferExternalProj
)
target_sources(ReferExternalProj_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(ReferExternalProj_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model ReferExternalProj
)
target_sources(ReferExternalProj_xmlSubscriber PRIVATE
  subscriber.cpp
)

dds_configure_test_files()

dds_add_test("tools/modeling/tests/ReferExternalProj/run_test.pl"
  COMMAND run_test.pl
)
