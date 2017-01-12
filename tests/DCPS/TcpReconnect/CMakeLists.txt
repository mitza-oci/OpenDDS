project(TcpReconnect CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(DDS_TcpReconnect_Idl
  OUTPUT_NAME DDS_TcpReconnect_Idl
  FOLDER tests/DCPS/TcpReconnect
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_TcpReconnect_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_TcpReconnect_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/TcpReconnect
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Shmem
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_TcpReconnect_Idl
                 OpenDDS_Udp
                 OpenDDS_Model
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(DDS_TcpReconnect_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_TcpReconnect_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/TcpReconnect
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Shmem
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 DDS_TcpReconnect_Idl
                 OpenDDS_Udp
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(DDS_TcpReconnect_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)


add_ace_exe(stub
  OUTPUT_NAME stub
  FOLDER tests/DCPS/TcpReconnect
  LINK_LIBRARIES ACE
)
target_cxx_sources(stub
  SOURCE_FILES stub.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/TcpReconnect/run_test.pl"
  COMMAND run_test.pl
)
