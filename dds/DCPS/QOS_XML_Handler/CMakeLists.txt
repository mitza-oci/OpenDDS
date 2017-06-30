ace_requires("NOT ACE_USES_WCHAR")

ace_add_lib(OpenDDS_QOS_XML_XSC_Handler
  OUTPUT_NAME OpenDDS_QOS_XML_XSC_Handler
  PACKAGE OpenDDS
  COMPILE_DEFINITIONS XML_USE_PTHREADS
  FOLDER OpenDDS/dds/DCPS
  DEFINE_SYMBOL XML_QOS_HANDLER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES TAO_AnyTypeCode
                        OpenDDS_Dcps
                        ACE_XML_Utils
)

ace_target_cxx_sources(OpenDDS_QOS_XML_XSC_Handler
  GLOB_HEADERS
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
)

