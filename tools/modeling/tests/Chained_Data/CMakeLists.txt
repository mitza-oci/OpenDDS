
dds_add_model_lib(Chained_Data)

ace_add_exe(Chained_Data_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Chained_Data CfTopic
)
target_sources(Chained_Data_xmlPublisher PRIVATE
  publisher.cpp
)

ace_add_exe(Chained_Data_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Chained_Data CfTopic
)
target_sources(Chained_Data_xmlSubscriber PRIVATE
  subscriber.cpp
)
