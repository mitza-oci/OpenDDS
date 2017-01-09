
find_package(XercesC)

requires(DDS4CCM_OPENDDS XercesC_FOUND)


add_ace_lib(OpenDDS_QOS_XML_XSC_Handler
  OUTPUT_NAME OpenDDS_QOS_XML_XSC_Handler
  COMPILE_DEFINITIONS XML_USE_PTHREADS
  FOLDER dds/DCPS/QOS_XML_Handler
  FEATURES GEN_OSTREAM
  DEFINE_SYMBOL XML_QOS_HANDLER_BUILD_DLL
  PUBLIC_INCLUDE_DIRECTORIES ${XercesC_INCLUDE_DIRS}
  PUBLIC_LINK_LIBRARIES TAO_AnyTypeCode
                        OpenDDS_Dcps
                        ${XercesC_LIBRARIES}
)
target_cxx_sources(OpenDDS_QOS_XML_XSC_Handler
  SOURCE_FILES DataReaderQos_Handler.cpp
               DataWriterQos_Handler.cpp
               ParticipantQos_Handler.cpp
               PublisherQos_Handler.cpp
               QOS_Common.cpp
               QOS_XML_Loader.cpp
               SubscriberQos_Handler.cpp
               TopicQos_Handler.cpp
               XML_File_Intf.cpp
               dds_qos.cpp
  HEADER_FILES DataReaderQos_Handler.h
               DataWriterQos_Handler.h
               ParticipantQos_Handler.h
               PublisherQos_Handler.h
               QOS_Common.h
               QOS_DataReader_T.h
               QOS_DataWriter_T.h
               QOS_DwDrTp_Base_T.h
               QOS_DwTp_Base_T.h
               QOS_PubSub_T.h
               QOS_Topic_T.h
               QOS_XML_Loader.h
               SubscriberQos_Handler.h
               TopicQos_Handler.h
               XML_File_Intf.h
               XML_QOS_Handler_Export.h
  TEMPLATE_FILES QOS_DataReader_T.cpp
                 QOS_DataWriter_T.cpp
                 QOS_DwDrTp_Base_T.cpp
                 QOS_DwTp_Base_T.cpp
                 QOS_PubSub_T.cpp
                 QOS_Topic_T.cpp
)

