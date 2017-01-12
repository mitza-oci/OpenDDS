project(LatencyBudget CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_lib(DDS_LatencyBudget_Idl
  OUTPUT_NAME DDS_LatencyBudget_Idl
  FOLDER tests/DCPS/LatencyBudget
  DEFINE_SYMBOL LATENCYBUDGET_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_LatencyBudget_Idl
  DDS_IDL_FLAGS -Wb,export_macro=LatencyBudget_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=LatencyBudget_export.h
                -Wb,stub_export_macro=LatencyBudget_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_LatencyBudget_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/LatencyBudget
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_LatencyBudget_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_LatencyBudget_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


ace_add_exe(DDS_LatencyBudget_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/LatencyBudget
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_LatencyBudget_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_LatencyBudget_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/LatencyBudget/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/LatencyBudget/run_test.pl late"
  COMMAND run_test.pl late
)
