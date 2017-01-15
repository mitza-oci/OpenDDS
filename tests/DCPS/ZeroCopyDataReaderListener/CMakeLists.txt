project(ZeroCopyDataReaderListener CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(ZeroCopyDRL_idl
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


ace_add_exe(ZeroCopyDRL_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/ZeroCopyDataReaderListener
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Model
                 ZeroCopyDRL_idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ZeroCopyDRL_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(ZeroCopyDRL_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/ZeroCopyDataReaderListener
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Model
                 ZeroCopyDRL_idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ZeroCopyDRL_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)


ace_add_exe(ZeroCopyDRL_StackSubscriber
  OUTPUT_NAME stack_subscriber
  FOLDER tests/DCPS/ZeroCopyDataReaderListener
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Model
                 ZeroCopyDRL_idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ZeroCopyDRL_StackSubscriber
  SOURCE_FILES DataReaderListener.cpp
               stack_subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ZeroCopyDataReaderListener/run_test.pl"
  COMMAND run_test.pl
)
