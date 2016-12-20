
project(StockQuoter CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

find_package(TAO_orbsvcs REQUIRED CONFIG)

add_ace_lib(StockQuoter_Common
  OUTPUT_NAME StockQuoterCommon
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/IntroductionToOpenDDS
  PUBLIC_INCLUDE_DIRECTORIES ${TAO_ROOT}/orbsvcs
  PUBLIC_LINK_LIBRARIES TAO_Svc_Utils
                        OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS StockQuoter_Common
  DDS_IDL_FLAGS -Wb,export_macro=StockQuoterCommon_Export
  TAO_IDL_FLAGS -I${TAO_ROOT}/orbsvcs
                -Wb,export_macro=StockQuoterCommon_Export
                -Wb,export_include=StockQuoterCommon_Export.h
  IDL_FILES StockQuoter.idl
)

add_ace_exe(StockQuoter_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/IntroductionToOpenDDS
  INCLUDE_DIRECTORIES ${TAO_ROOT}/orbsvcs
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 TAO_Svc_Utils
                 StockQuoter_Common
                 OpenDDS_Dcps
)

add_ace_exe(StockQuoter_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES ExchangeEventDataReaderListenerImpl.cpp
               QuoteDataReaderListenerImpl.cpp
               subscriber.cpp
  HEADER_FILES ExchangeEventDataReaderListenerImpl.h
               QuoteDataReaderListenerImpl.h
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/IntroductionToOpenDDS
  INCLUDE_DIRECTORIES ${TAO_ROOT}/orbsvcs
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 StockQuoter_Common
                 OpenDDS_Dcps
)
#####################################
link_test_files_to_build_tree()