
project(BidirMessenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_BidirMessenger_Idl
  OUTPUT_NAME DDS_BidirMessenger_Idl
  FOLDER tests/DCPS/BidirMessenger
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
  FOLDER tests/DCPS/BidirMessenger
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_BidirMessenger_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_BidirMessenger_Pubsub
  SOURCE_FILES DataReaderListener.cpp
               Writer.cpp
               pubsub.cpp
  HEADER_FILES DataReaderListener.h
               Writer.h
)

