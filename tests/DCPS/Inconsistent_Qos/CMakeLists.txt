project(Inconsistent_Qos CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Inconsistent_Qos_idl
  OUTPUT_NAME DDS_Inconsistent_Qos_idl
  FOLDER tests/DCPS/Inconsistent_Qos
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Inconsistent_Qos_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Inconsistent_Qos_Inconsistent_Qos
  OUTPUT_NAME inconsistent_qos
  SOURCE_FILES inconsistent_qos.cpp
  REQUIRES "TARGET OpenDDS_QOS_XML_XSC_Handler"
  FOLDER tests/DCPS/Inconsistent_Qos
  LINK_LIBRARIES OpenDDS_QOS_XML_XSC_Handler
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Inconsistent_Qos_idl
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Inconsistent_Qos/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS DDS4CCM_OPENDDS DCPS_MIN
)
