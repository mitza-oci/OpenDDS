project(LatencyBudget CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(DDS_LatencyBudget_idl
  OUTPUT_NAME DDS_LatencyBudget_idl
  FOLDER tests/DCPS/LatencyBudget
  DEFINE_SYMBOL LATENCYBUDGET_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_LatencyBudget_idl
  DDS_IDL_FLAGS -Wb,export_macro=LatencyBudget_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=LatencyBudget_export.h
                -Wb,stub_export_macro=LatencyBudget_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_LatencyBudget_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES Writer.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/LatencyBudget
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_LatencyBudget_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_LatencyBudget_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/LatencyBudget
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_LatencyBudget_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/LatencyBudget/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/LatencyBudget/run_test.pl late"
  COMMAND run_test.pl late
)
