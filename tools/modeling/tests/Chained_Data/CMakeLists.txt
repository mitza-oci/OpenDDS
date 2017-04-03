
dds_add_model_lib(Chained_Data)

ace_add_exe(Chained_Data_xmlPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Model Chained_Data CfTopic
)
ace_target_cxx_sources(Chained_Data_xmlPublisher
  SOURCE_FILES publisher.cpp
)

ace_add_exe(Chained_Data_xmlSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Model Chained_Data CfTopic
)
ace_target_cxx_sources(Chained_Data_xmlSubscriber
  SOURCE_FILES subscriber.cpp
)
