
project(Messenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_lib(Monitor_Messenger_Idl
  OUTPUT_NAME Monitor_Messenger_Idl
  FOLDER tests/DCPS/Monitor
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS Monitor_Messenger_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(Monitor_Messenger_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Monitor
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_monitor
                 Monitor_Messenger_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Monitor_Messenger_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(Monitor_Messenger_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Monitor
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_monitor
                 Monitor_Messenger_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Monitor_Messenger_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)


ace_add_exe(Monitor_Messenger_Monitor
  OUTPUT_NAME monitor
  FOLDER tests/DCPS/Monitor
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_monitor
                 Monitor_Messenger_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Monitor_Messenger_Monitor
  SOURCE_FILES DPMDataReaderListener.cpp
               DRMDataReaderListener.cpp
               DRPerMDataReaderListener.cpp
               DWMDataReaderListener.cpp
               DWPerMDataReaderListener.cpp
               PublisherMDataReaderListener.cpp
               SPMDataReaderListener.cpp
               SubscriberMDataReaderListener.cpp
               TopicMDataReaderListener.cpp
               TransportMDataReaderListener.cpp
               monitor.cpp
  HEADER_FILES DPMDataReaderListener.h
               DRMDataReaderListener.h
               DRPerMDataReaderListener.h
               DWMDataReaderListener.h
               DWPerMDataReaderListener.h
               PublisherMDataReaderListener.h
               SPMDataReaderListener.h
               SubscriberMDataReaderListener.h
               TopicMDataReaderListener.h
               TransportMDataReaderListener.h
)

if (MSVC)
  target_compile_options(Monitor_Messenger_Monitor /bigobj)
endif()

