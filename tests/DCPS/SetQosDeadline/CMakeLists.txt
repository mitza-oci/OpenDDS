project(SetQosDeadline CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(SetQosDeadline_idl
  OUTPUT_NAME SetQosDeadline_idl
  FOLDER tests/DCPS/SetQosDeadline
  DEFINE_SYMBOL SETQOSDEADLINE_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS SetQosDeadline_idl
  DDS_IDL_FLAGS -Wb,export_macro=SetQosDeadline_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SetQosDeadline_export.h
                -Wb,stub_export_macro=SetQosDeadline_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(SetQosDeadline_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/SetQosDeadline
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 SetQosDeadline_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(SetQosDeadline_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/SetQosDeadline
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 SetQosDeadline_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/SetQosDeadline/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/SetQosDeadline/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
