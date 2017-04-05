project(Ownership CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE OPENDDS_HAS_OWNERSHIP_KIND_EXCLUSIVE)

ace_add_lib(DDS_Ownership_Idl
  OUTPUT_NAME DDS_Ownership_Idl

  DEFINE_SYMBOL OWNERSHIP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Ownership_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Ownership_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Ownership_export.h
                -Wb,stub_export_macro=Ownership_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Ownership_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_Ownership_Idl
                 OpenDDS_Udp
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(DDS_Ownership_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_Ownership_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_Ownership_Idl
                 OpenDDS_Udp
                 OpenDDS_Default_Discovery
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(DDS_Ownership_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Ownership/run_test.pl"
  COMMAND run_test.pl
)


dds_add_test("tests/DCPS/Ownership/run_test.pl update_strength"
  COMMAND run_test.pl update_strength
  REQUIRES OPENDDS_HAS_BUILT_IN_TOPICS
)


dds_add_test("tests/DCPS/Ownership/run_test.pl liveliness_change"
  COMMAND run_test.pl liveliness_change
)


dds_add_test("tests/DCPS/Ownership/run_test.pl miss_deadline"
  COMMAND run_test.pl miss_deadline
)
