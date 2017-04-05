
project(BidirMessenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_BidirMessenger_Idl
  OUTPUT_NAME DDS_BidirMessenger_Idl

  DEFINE_SYMBOL BIDIRMESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_BidirMessenger_Idl
  DDS_IDL_FLAGS -Wb,export_macro=BidirMessenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=BidirMessenger_export.h
                -Wb,stub_export_macro=BidirMessenger_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_BidirMessenger_Pubsub
  OUTPUT_NAME pubsub

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_BidirMessenger_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_BidirMessenger_Pubsub
  SOURCE_FILES DataReaderListener.cpp
               Writer.cpp
               pubsub.cpp
  HEADER_FILES DataReaderListener.h
               Writer.h
)

