project(TcpReconnect CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(DDS_TcpReconnect_idl
  OUTPUT_NAME DDS_TcpReconnect_idl
  FOLDER tests/DCPS/TcpReconnect
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_TcpReconnect_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_TcpReconnect_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/TcpReconnect
  LINK_LIBRARIES OpenDDS_Shmem
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_TcpReconnect_idl
                 OpenDDS_Udp
                 OpenDDS_Model
                 OpenDDS_Rtps_Udp
)

add_ace_exe(DDS_TcpReconnect_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/TcpReconnect
  LINK_LIBRARIES OpenDDS_Shmem
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_TcpReconnect_idl
                 OpenDDS_Udp
                 OpenDDS_Rtps_Udp
)

add_ace_exe(stub
  OUTPUT_NAME stub
  SOURCE_FILES stub.cpp
  FOLDER tests/DCPS/TcpReconnect
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/TcpReconnect/run_test.pl"
  COMMAND run_test.pl
)
