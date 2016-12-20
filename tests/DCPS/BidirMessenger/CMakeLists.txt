
project(BidirMessenger CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_BidirMessenger_idl
  OUTPUT_NAME DDS_BidirMessenger_idl
  FOLDER tests/DCPS/BidirMessenger
  DEFINE_SYMBOL BIDIRMESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_BidirMessenger_idl
  DDS_IDL_FLAGS -Wb,export_macro=BidirMessenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=BidirMessenger_export.h
                -Wb,stub_export_macro=BidirMessenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_BidirMessenger_PubSub
  OUTPUT_NAME pubsub
  SOURCE_FILES pubsub.cpp
               Writer.cpp
               DataReaderListener.cpp
  HEADER_FILES Writer.h
               DataReaderListener.h
  FOLDER tests/DCPS/BidirMessenger
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_BidirMessenger_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
