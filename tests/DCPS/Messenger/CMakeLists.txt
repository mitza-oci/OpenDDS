project(Messenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_Messenger_Idl
  OUTPUT_NAME DDS_Messenger_Idl
  FOLDER tests/DCPS/Messenger
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Messenger_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Messenger_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Messenger
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Messenger_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)
ace_target_cxx_sources(DDS_Messenger_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)



ace_add_exe(DDS_Messenger_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Messenger
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Messenger_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)


ace_add_exe(DDS_Messenger_Stacksubscriber
  OUTPUT_NAME stack_subscriber
  FOLDER tests/DCPS/Messenger
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Messenger_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_Stacksubscriber
  SOURCE_FILES DataReaderListener.cpp
               stack_subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()

file(GLOB files *.ini)
file(COPY ${files} run_test.pl run_corbaloc_test.pl
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})


dds_add_test("tests/DCPS/Messenger/run_test.pl"
  COMMAND run_test.pl
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_test.pl default_tcp"
  COMMAND run_test.pl default_tcp
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_test.pl thread_per"
  COMMAND run_test.pl thread_per
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_test.pl default_udp"
  COMMAND run_test.pl default_udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_test.pl multicast"
  COMMAND run_test.pl multicast
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST
)


dds_add_test("tests/DCPS/Messenger/run_test.pl default_multicast"
  COMMAND run_test.pl default_multicast
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST
)


dds_add_test("tests/DCPS/Messenger/run_test.pl shmem"
  COMMAND run_test.pl shmem
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


dds_add_test("tests/DCPS/Messenger/run_test.pl nobits"
  COMMAND run_test.pl nobits
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_test.pl stack"
  COMMAND run_test.pl stack
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_test.pl ipv6"
  COMMAND run_test.pl ipv6
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE ACE_HAS_IPV6
  LABELS IPV6
)


dds_add_test("tests/DCPS/Messenger/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/Messenger/run_test.pl rtps_unicast"
  COMMAND run_test.pl rtps_unicast
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/Messenger/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES OWNERSHIP_PROFILE
  LABELS MCAST RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/Messenger/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/Messenger/run_test.pl rtps_disc_tcp thread_per"
  COMMAND run_test.pl rtps_disc_tcp thread_per
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/Messenger/run_corbaloc_test.pl"
  COMMAND run_corbaloc_test.pl
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_corbaloc_test.pl host_port_only"
  COMMAND run_corbaloc_test.pl host_port_only
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/Messenger/run_ns_test.pl"
  COMMAND run_ns_test.pl
  REQUIRES "TARGET TAO_Svc_Utils" "TARGET Naming_Service" OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)
