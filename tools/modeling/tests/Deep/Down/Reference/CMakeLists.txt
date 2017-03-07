dds_add_model_lib(DeepDownReference
  PUBLIC_LINK_LIBRARIES MessengerMixed
)

ace_add_exe(DeepDownReference_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model DeepDownReference
)
target_sources(DeepDownReference_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(DeepDownReference_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model DeepDownReference
)
target_sources(DeepDownReference_xmlSubscriber PRIVATE
  subscriber.cpp
)
