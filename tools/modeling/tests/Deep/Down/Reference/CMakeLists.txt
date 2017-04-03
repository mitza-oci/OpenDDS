dds_add_model_lib(DeepDownReference
  PUBLIC_LINK_LIBRARIES MessengerMixed
)

ace_add_exe(DeepDownReference_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model DeepDownReference
)
ace_target_cxx_sources(DeepDownReference_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(DeepDownReference_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model DeepDownReference
)
ace_target_cxx_sources(DeepDownReference_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)
