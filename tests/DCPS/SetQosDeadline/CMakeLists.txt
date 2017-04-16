project(SetQosDeadline CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(SetQosDeadline_Idl
  OUTPUT_NAME SetQosDeadline_Idl
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


ace_add_exe(SetQosDeadline_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 SetQosDeadline_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(SetQosDeadline_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(SetQosDeadline_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 SetQosDeadline_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(SetQosDeadline_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/SetQosDeadline/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/SetQosDeadline/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
