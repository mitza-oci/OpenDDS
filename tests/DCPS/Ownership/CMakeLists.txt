project(Ownership CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE OWNERSHIP_KIND_EXCLUSIVE)

add_ace_lib(DDS_Ownership_Idl
  OUTPUT_NAME DDS_Ownership_Idl
  FOLDER tests/DCPS/Ownership
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


add_ace_exe(DDS_Ownership_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Ownership
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_Ownership_Idl
                 OpenDDS_Udp
                 OpenDDS_Model
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(DDS_Ownership_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_Ownership_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Ownership
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_Ownership_Idl
                 OpenDDS_Udp
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(DDS_Ownership_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Ownership/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/Ownership/run_test.pl update_strength"
  COMMAND run_test.pl update_strength
  REQUIRES BUILT_IN_TOPICS
)


add_dds_test("tests/DCPS/Ownership/run_test.pl liveliness_change"
  COMMAND run_test.pl liveliness_change
)


add_dds_test("tests/DCPS/Ownership/run_test.pl miss_deadline"
  COMMAND run_test.pl miss_deadline
)
