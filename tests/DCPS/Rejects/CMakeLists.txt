project(Rejects CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_Rejects_Idl
  OUTPUT_NAME DDS_Rejects_Idl
  FOLDER tests/DCPS/Rejects
  DEFINE_SYMBOL REJECTS_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Rejects_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Rejects_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Rejects_export.h
                -Wb,stub_export_macro=Rejects_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Rejects_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Rejects
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Rejects_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Rejects_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_Rejects_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Rejects
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Rejects_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Rejects_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Rejects/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/Rejects/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
  RESOURCE_LOCK RTPS
)
