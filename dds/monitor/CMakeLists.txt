ace_requires ("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(OpenDDS_monitor
  PACKAGE OpenDDS

  DEFINE_SYMBOL OPENDDS_MONITOR_BUILD_DLL
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

dds_idl_sources(
  TARGETS OpenDDS_monitor
  DDS_IDL_FLAGS -Wb,export_macro=OpenDDS_monitor_Export
  TAO_IDL_FLAGS -Wb,export_macro=OpenDDS_monitor_Export -Wb,export_include=dds/monitor/monitor_export.h
  IDL_FILES monitor.idl
)

ace_target_cxx_sources(OpenDDS_monitor
  SOURCE_FILES DPMonitorImpl.cpp
               DRMonitorImpl.cpp
               DRPeriodicMonitorImpl.cpp
               DWMonitorImpl.cpp
               DWPeriodicMonitorImpl.cpp
               MonitorFactoryImpl.cpp
               PublisherMonitorImpl.cpp
               SPMonitorImpl.cpp
               SubscriberMonitorImpl.cpp
               TopicMonitorImpl.cpp
               TransportMonitorImpl.cpp
  HEADER_FILES DPMonitorImpl.h
               DRMonitorImpl.h
               DRPeriodicMonitorImpl.h
               DWMonitorImpl.h
               DWPeriodicMonitorImpl.h
               MonitorFactoryImpl.h
               PublisherMonitorImpl.h
               SPMonitorImpl.h
               SubscriberMonitorImpl.h
               TopicMonitorImpl.h
               TransportMonitorImpl.h
               monitor_export.h
)

if (MSVC)
  target_compile_options(OpenDDS_monitor /bigobj)
endif(MSVC)

