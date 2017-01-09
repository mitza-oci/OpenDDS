project(Messenger_Imr CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires("NOT MINIMUM_CORBA" "TARGET TAO_Svc_Utils" NO_OPENDDS_SAFETY_PROFILE "NOT CORBA_E_MICRO" "NOT CORBA_E_COMPACT")

add_ace_lib(DDS_Messenger_Imr_Idl
  OUTPUT_NAME DDS_Messenger_Imr_Idl
  FOLDER examples/DCPS/Messenger_Imr
  DEFINE_SYMBOL MESSENGER_IMR_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Messenger_Imr_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Imr_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_Imr_export.h
                -Wb,stub_export_macro=Messenger_Imr_Export
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_Messenger_Imr_Publisher
  OUTPUT_NAME publisher
  FOLDER examples/DCPS/Messenger_Imr
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_Idl
)
target_cxx_sources(DDS_Messenger_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_Messenger_Imr_Subscriber
  OUTPUT_NAME subscriber
  FOLDER examples/DCPS/Messenger_Imr
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_Idl
)
target_cxx_sources(DDS_Messenger_Imr_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("examples/DCPS/Messenger_Imr/run_test.pl"
  COMMAND run_test.pl
)
