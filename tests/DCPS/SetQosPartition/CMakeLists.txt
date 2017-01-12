project(SetQosPartition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(SetQosPartition_Idl
  OUTPUT_NAME SetQosPartition_Idl
  FOLDER tests/DCPS/SetQosPartition
  DEFINE_SYMBOL SETQOSPARTITION_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS SetQosPartition_Idl
  DDS_IDL_FLAGS -Wb,export_macro=SetQosPartition_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SetQosPartition_export.h
                -Wb,stub_export_macro=SetQosPartition_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(SetQosPartition_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/SetQosPartition
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
                 SetQosPartition_Idl
)
ace_target_cxx_sources(SetQosPartition_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(SetQosPartition_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/SetQosPartition
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES SetQosPartition_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(SetQosPartition_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/SetQosPartition/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/SetQosPartition/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)


dds_add_test("tests/DCPS/SetQosPartition/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
)
