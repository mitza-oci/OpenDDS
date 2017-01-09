
project(Messenger_IOGR_Imr CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(DDS_Messenger_IOGR_Imr_Idl
  OUTPUT_NAME DDS_Messenger_IOGR_Imr_Idl
  FOLDER examples/DCPS/Messenger_IOGR_Imr
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


add_ace_exe(DDS_Messenger_IOGR_Imr_Aggregator
  OUTPUT_NAME Aggregator
  REQUIRES "NOT CORBA_E_COMPACT"
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  ASPECTS NEGOTIATE_CODESETS
          TAO
  LINK_LIBRARIES TAO_FT_ServerORB
                 TAO_AnyTypeCode
                 TAO_FT_ClientORB
                 TAO_Valuetype
                 TAO_IORManip
                 TAO_PortableServer
)
target_cxx_sources(DDS_Messenger_IOGR_Imr_Aggregator
  SOURCE_FILES Aggregator.cpp
  HEADER_FILES Aggregator.h
)


add_ace_exe(DDS_Messenger_IOGR_Imr_Publisher
  OUTPUT_NAME publisher
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES DDS_Messenger_IOGR_Imr_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Messenger_IOGR_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_Messenger_IOGR_Imr_Subscriber
  OUTPUT_NAME subscriber
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES DDS_Messenger_IOGR_Imr_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Messenger_IOGR_Imr_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

