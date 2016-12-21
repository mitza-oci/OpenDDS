project(Ownership CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE OWNERSHIP_KIND_EXCLUSIVE)

add_ace_lib(DDS_Ownership_idl
  OUTPUT_NAME DDS_Ownership_idl
  FOLDER tests/DCPS/Ownership
  DEFINE_SYMBOL OWNERSHIP_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Ownership_idl
  DDS_IDL_FLAGS -Wb,export_macro=Ownership_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Ownership_export.h
                -Wb,stub_export_macro=Ownership_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Ownership_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Ownership
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_Ownership_idl
                 OpenDDS_Udp
                 OpenDDS_Model
                 OpenDDS_Rtps_Udp
)

add_ace_exe(DDS_Ownership_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Ownership
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Multicast
                 OpenDDS_Udp
                 DDS_Ownership_idl
                 OpenDDS_Tcp
                 OpenDDS_Rtps_Udp
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
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
