project(Messenger CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Messenger_idl
  OUTPUT_NAME DDS_Messenger_idl
  FOLDER tests/DCPS/Messenger
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Messenger_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Messenger_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Messenger
  LINK_LIBRARIES DDS_Messenger_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Messenger_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Messenger
  LINK_LIBRARIES DDS_Messenger_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Messenger_StackSubscriber
  OUTPUT_NAME stack_subscriber
  SOURCE_FILES stack_subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Messenger
  LINK_LIBRARIES DDS_Messenger_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Messenger/run_test.pl"
  COMMAND run_test.pl
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_test.pl default_tcp"
  COMMAND run_test.pl default_tcp
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_test.pl thread_per"
  COMMAND run_test.pl thread_per
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_test.pl default_udp"
  COMMAND run_test.pl default_udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_test.pl multicast"
  COMMAND run_test.pl multicast
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST
)


add_dds_test("tests/DCPS/Messenger/run_test.pl default_multicast"
  COMMAND run_test.pl default_multicast
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST
)


add_dds_test("tests/DCPS/Messenger/run_test.pl shmem"
  COMMAND run_test.pl shmem
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


add_dds_test("tests/DCPS/Messenger/run_test.pl nobits"
  COMMAND run_test.pl nobits
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_test.pl stack"
  COMMAND run_test.pl stack
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_test.pl ipv6"
  COMMAND run_test.pl ipv6
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS IPV6
)


add_dds_test("tests/DCPS/Messenger/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
)


add_dds_test("tests/DCPS/Messenger/run_test.pl rtps_unicast"
  COMMAND run_test.pl rtps_unicast
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


add_dds_test("tests/DCPS/Messenger/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES OWNERSHIP_PROFILE
  LABELS MCAST RTPS
)


add_dds_test("tests/DCPS/Messenger/run_test.pl rtps_disc_tcp"
  COMMAND run_test.pl rtps_disc_tcp
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
)


add_dds_test("tests/DCPS/Messenger/run_test.pl rtps_disc_tcp thread_per"
  COMMAND run_test.pl rtps_disc_tcp thread_per
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST RTPS
)


add_dds_test("tests/DCPS/Messenger/run_corbaloc_test.pl"
  COMMAND run_corbaloc_test.pl
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_corbaloc_test.pl host_port_only"
  COMMAND run_corbaloc_test.pl host_port_only
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Messenger/run_ns_test.pl"
  COMMAND run_ns_test.pl
  REQUIRES "TARGET TAO_Svc_Utils" OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)
