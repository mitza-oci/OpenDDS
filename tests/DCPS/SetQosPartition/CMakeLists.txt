project(SetQosPartition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(SetQosPartition_idl
  OUTPUT_NAME SetQosPartition_idl
  FOLDER tests/DCPS/SetQosPartition
  DEFINE_SYMBOL SETQOSPARTITION_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS SetQosPartition_idl
  DDS_IDL_FLAGS -Wb,export_macro=SetQosPartition_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SetQosPartition_export.h
                -Wb,stub_export_macro=SetQosPartition_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(SetQosPartition_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/SetQosPartition
  LINK_LIBRARIES OpenDDS_Model
                 SetQosPartition_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(SetQosPartition_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/SetQosPartition
  LINK_LIBRARIES SetQosPartition_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/SetQosPartition/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/SetQosPartition/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)


add_dds_test("tests/DCPS/SetQosPartition/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
)
