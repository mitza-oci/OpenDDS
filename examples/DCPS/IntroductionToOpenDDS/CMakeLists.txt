
project(StockQuoter CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(StockQuoter_Common
  OUTPUT_NAME StockQuoterCommon
  DEFINE_SYMBOL STOCKQUOTERCOMMON_BUILD_DLL
  PUBLIC_INCLUDE_DIRECTORIES ${TAO_INCLUDE_DIR}/orbsvcs
  PUBLIC_LINK_LIBRARIES TAO_AnyTypeCode
                        TAO_Svc_Utils
                        OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS StockQuoter_Common
  DDS_IDL_FLAGS -Wb,export_macro=StockQuoterCommon_Export
  TAO_IDL_FLAGS -Sa
                -St
                -I${TAO_INCLUDE_DIR}/orbsvcs
                -Wb,export_macro=StockQuoterCommon_Export
                -Wb,export_include=StockQuoterCommon_Export.h
                -I${TAO_INCLUDE_DIR}/orbsvcs
  IDL_FILES StockQuoter.idl
)


ace_add_exe(StockQuoter_Publisher
  OUTPUT_NAME publisher

  INCLUDE_DIRECTORIES ${TAO_INCLUDE_DIR}/orbsvcs
  LINK_LIBRARIES TAO_AnyTypeCode
                 OpenDDS_Tcp
                 TAO_Svc_Utils
                 StockQuoter_Common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(StockQuoter_Publisher
  SOURCE_FILES publisher.cpp
)


ace_add_exe(StockQuoter_Subscriber
  OUTPUT_NAME subscriber

  INCLUDE_DIRECTORIES ${TAO_INCLUDE_DIR}/orbsvcs
  LINK_LIBRARIES OpenDDS_Tcp
                 StockQuoter_Common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(StockQuoter_Subscriber
  SOURCE_FILES ExchangeEventDataReaderListenerImpl.cpp
               QuoteDataReaderListenerImpl.cpp
               subscriber.cpp
  HEADER_FILES ExchangeEventDataReaderListenerImpl.h
               QuoteDataReaderListenerImpl.h
)

