project(Messenger_Imr CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires("TARGET TAO_Svc_Utils" NO_OPENDDS_SAFETY_PROFILE "NOT CORBA_E_MICRO" "NOT CORBA_E_COMPACT" "NOT MINIMUM_CORBA" "TARGET tao_imr")

add_ace_lib(DDS_Messenger_Imr_idl
  OUTPUT_NAME DDS_Messenger_Imr_idl
  FOLDER examples/DCPS/Messenger_Imr
  DEFINE_SYMBOL MESSENGER_IMR_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Messenger_Imr_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Imr_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_Imr_export.h
                -Wb,stub_export_macro=Messenger_Imr_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Messenger_Imr_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER examples/DCPS/Messenger_Imr
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(DDS_Messenger_Imr_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER examples/DCPS/Messenger_Imr
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("examples/DCPS/Messenger_Imr/run_test.pl"
  COMMAND run_test.pl
)
