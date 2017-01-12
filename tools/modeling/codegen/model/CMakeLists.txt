
ace_add_lib(OpenDDS_Model
  DEFINE_SYMBOL OPENDDS_MODEL_BUILD_DLL
  PACKAGE OpenDDS
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
  PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>
)

ace_target_cxx_sources(OpenDDS_Model
  SOURCE_FILES Application.cpp
               Config.cpp
               Delegate.cpp
               Entities.cpp
               EntityProfiles.cpp
               NullListener.cpp
               NullParticipantListener.cpp
               NullPublisherListener.cpp
               NullReaderListener.cpp
               NullSubscriberListener.cpp
               NullTopicListener.cpp
               NullWriterListener.cpp
               Sync.cpp
               TransportDirectives.cpp
               Utilities.cpp
  HEADER_FILES Application.h
               Config.h
               CopyQos.h
               Delegate.h
               Entities.h
               EntityProfiles.h
               Exceptions.h
               NullListener.h
               NullParticipantListener.h
               NullPublisherListener.h
               NullReaderListener.h
               NullSubscriberListener.h
               NullTopicListener.h
               NullWriterListener.h
               Service_T.h
               Sync.h
               TransportDirectives.h
               Utilities.h
               model_export.h
  INLINE_FILES Config.inl
               Entities.inl
  TEMPLATE_FILES Service_T.cpp
)

