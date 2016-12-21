
project(Priority CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(perf_Priority_idl
  OUTPUT_NAME perf_Priority_idl
  FOLDER performance-tests/DCPS/Priority
  DEFINE_SYMBOL PRIORITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS perf_Priority_idl
  DDS_IDL_FLAGS -Wb,export_macro=Priority_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Priority_export.h
                -Wb,stub_export_macro=Priority_Export
  IDL_FILES Test.idl
)

add_ace_exe(perf_Priority_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Writer.cpp
               Publisher.cpp
               Options.cpp
               PublicationProfile.cpp
               publisher_main.cpp
  HEADER_FILES Writer.h
               Publisher.h
               Options.h
               PublicationProfile.h
  INLINE_FILES Options.inl
  FOLDER performance-tests/DCPS/Priority
  LINK_LIBRARIES perf_Priority_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(perf_Priority_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               Options.cpp
               DataReaderListener.cpp
               PublicationProfile.cpp
               Commas.cpp
               subscriber_main.cpp
  HEADER_FILES Subscriber.h
               Options.h
               DataReaderListener.h
               PublicationProfile.h
               Commas.h
  INLINE_FILES Options.inl
  FOLDER performance-tests/DCPS/Priority
  LINK_LIBRARIES perf_Priority_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
