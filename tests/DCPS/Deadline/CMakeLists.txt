project(Deadline CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Deadline_Idl
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


add_ace_exe(DDS_Deadline_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Deadline
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Deadline_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Deadline_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


add_ace_exe(DDS_Deadline_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Deadline
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Deadline_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Deadline_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Deadline/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Deadline/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
