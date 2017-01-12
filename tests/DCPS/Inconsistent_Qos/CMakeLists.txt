project(Inconsistent_Qos CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Inconsistent_Qos_Idl
  OUTPUT_NAME DDS_Inconsistent_Qos_Idl
  FOLDER tests/DCPS/Inconsistent_Qos
  DEFINE_SYMBOL MESSENGER_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Inconsistent_Qos_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_export.h
                -Wb,stub_export_macro=Messenger_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_Inconsistent_Qos_Inconsistent_qos
  OUTPUT_NAME inconsistent_qos
  FOLDER tests/DCPS/Inconsistent_Qos
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_QOS_XML_XSC_Handler
                 DDS_Inconsistent_Qos_Idl
)
target_cxx_sources(DDS_Inconsistent_Qos_Inconsistent_qos
  SOURCE_FILES inconsistent_qos.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Inconsistent_Qos/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS DDS4CCM_OPENDDS DCPS_MIN
)
