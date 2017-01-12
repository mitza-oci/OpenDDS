project(Deadline CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_Deadline_Idl
  OUTPUT_NAME DDS_Deadline_Idl
  FOLDER tests/DCPS/Deadline
  DEFINE_SYMBOL DEADLINE_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Deadline_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Deadline_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Deadline_export.h
                -Wb,stub_export_macro=Deadline_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Deadline_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Deadline
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Deadline_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_Deadline_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


ace_add_exe(DDS_Deadline_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Deadline
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Deadline_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_Deadline_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Deadline/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Deadline/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
