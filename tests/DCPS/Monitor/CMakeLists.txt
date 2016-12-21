
project(Messenger CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(Monitor_Messenger_idl
  OUTPUT_NAME Monitor_Messenger_idl
  FOLDER tests/DCPS/Monitor
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS Monitor_Messenger_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(Monitor_Messenger_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Monitor
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_monitor
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 Monitor_Messenger_idl
)

add_ace_exe(Monitor_Messenger_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Monitor
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_monitor
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 Monitor_Messenger_idl
)

add_ace_exe(Monitor_Messenger_monitor
  OUTPUT_NAME monitor
  SOURCE_FILES monitor.cpp
               SPMDataReaderListener.cpp
               DPMDataReaderListener.cpp
               TopicMDataReaderListener.cpp
               PublisherMDataReaderListener.cpp
               SubscriberMDataReaderListener.cpp
               DWMDataReaderListener.cpp
               DWPerMDataReaderListener.cpp
               DRMDataReaderListener.cpp
               DRPerMDataReaderListener.cpp
               TransportMDataReaderListener.cpp
  HEADER_FILES SPMDataReaderListener.h
               DPMDataReaderListener.h
               TopicMDataReaderListener.h
               PublisherMDataReaderListener.h
               SubscriberMDataReaderListener.h
               DWMDataReaderListener.h
               DWPerMDataReaderListener.h
               DRMDataReaderListener.h
               DRPerMDataReaderListener.h
               TransportMDataReaderListener.h
  FOLDER tests/DCPS/Monitor
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_monitor
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 Monitor_Messenger_idl
)
if (MSVC)
  target_compile_options(Monitor_Messenger_monitor /bigobj)
endif()
