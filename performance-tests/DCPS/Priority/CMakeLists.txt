
project(Priority CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(perf_Priority_Idl
  OUTPUT_NAME perf_Priority_Idl
  FOLDER performance-tests/DCPS/Priority
  DEFINE_SYMBOL PRIORITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS perf_Priority_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Priority_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Priority_export.h
                -Wb,stub_export_macro=Priority_Export
  IDL_FILES Test.idl
)


ace_add_exe(perf_Priority_Publisher
  OUTPUT_NAME publisher
  FOLDER performance-tests/DCPS/Priority
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 perf_Priority_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(perf_Priority_Publisher
  SOURCE_FILES Options.cpp
               PublicationProfile.cpp
               Publisher.cpp
               Writer.cpp
               publisher_main.cpp
  HEADER_FILES Options.h
               PublicationProfile.h
               Publisher.h
               Writer.h
  INLINE_FILES Options.inl
)


ace_add_exe(perf_Priority_Subscriber
  OUTPUT_NAME subscriber
  FOLDER performance-tests/DCPS/Priority
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 perf_Priority_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(perf_Priority_Subscriber
  SOURCE_FILES Commas.cpp
               DataReaderListener.cpp
               Options.cpp
               PublicationProfile.cpp
               Subscriber.cpp
               subscriber_main.cpp
  HEADER_FILES Commas.h
               DataReaderListener.h
               Options.h
               PublicationProfile.h
               Subscriber.h
  INLINE_FILES Options.inl
)

