project(ZeroCopyDataReaderListener CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(ZeroCopyDRL_idl
  OUTPUT_NAME ZeroCopyDRL_idl
  FOLDER tests/DCPS/ZeroCopyDataReaderListener
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS ZeroCopyDRL_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(ZeroCopyDRL_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/ZeroCopyDataReaderListener
  LINK_LIBRARIES OpenDDS_Model
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ZeroCopyDRL_idl
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(ZeroCopyDRL_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/ZeroCopyDataReaderListener
  LINK_LIBRARIES OpenDDS_Model
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ZeroCopyDRL_idl
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(ZeroCopyDRL_StackSubscriber
  OUTPUT_NAME stack_subscriber
  SOURCE_FILES stack_subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/ZeroCopyDataReaderListener
  LINK_LIBRARIES OpenDDS_Model
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ZeroCopyDRL_idl
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ZeroCopyDataReaderListener/run_test.pl"
  COMMAND run_test.pl
)
