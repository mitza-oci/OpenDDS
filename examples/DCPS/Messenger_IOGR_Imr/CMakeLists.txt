
project(Messenger_IOGR_Imr CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_requires("TARGET ImR_Locator_Service"
             "TARGET ImR_Activator_Service"
             "TARGET tao_imr"
             "NOT OPENDDS_SAFETY_PROFILE"
)

ace_add_lib(DDS_Messenger_IOGR_Imr_Idl
  OUTPUT_NAME DDS_Messenger_IOGR_Imr_Idl

  DEFINE_SYMBOL MESSENGER_IOGR_IMR_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Messenger_IOGR_Imr_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_IOGR_Imr_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_IOGR_Imr_export.h
                -Wb,stub_export_macro=Messenger_IOGR_Imr_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Messenger_IOGR_Imr_Aggregator
  OUTPUT_NAME Aggregator

  LINK_LIBRARIES For_OrbsvcsExe
                 TAO_FT_ServerORB
                 TAO_FT_ClientORB
                 TAO_Valuetype
                 TAO_IORManip
                 TAO_PortableServer
)
ace_target_cxx_sources(DDS_Messenger_IOGR_Imr_Aggregator
  SOURCE_FILES Aggregator.cpp
  HEADER_FILES Aggregator.h
)


ace_add_exe(DDS_Messenger_IOGR_Imr_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES DDS_Messenger_IOGR_Imr_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_IOGR_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)
ace_target_cxx_sources(DDS_Messenger_IOGR_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)



ace_add_exe(DDS_Messenger_IOGR_Imr_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES DDS_Messenger_IOGR_Imr_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_IOGR_Imr_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()
