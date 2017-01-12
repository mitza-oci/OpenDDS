project(SetQosDeadline CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(SetQosDeadline_Idl
  OUTPUT_NAME SetQosDeadline_Idl
  FOLDER tests/DCPS/SetQosDeadline
  DEFINE_SYMBOL SETQOSDEADLINE_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS SetQosDeadline_Idl
  DDS_IDL_FLAGS -Wb,export_macro=SetQosDeadline_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SetQosDeadline_export.h
                -Wb,stub_export_macro=SetQosDeadline_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(SetQosDeadline_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/SetQosDeadline
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES SetQosDeadline_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(SetQosDeadline_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(SetQosDeadline_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/SetQosDeadline
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES SetQosDeadline_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(SetQosDeadline_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/SetQosDeadline/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/SetQosDeadline/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
