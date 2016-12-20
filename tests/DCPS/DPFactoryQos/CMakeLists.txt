project(DPFactoryQos CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_DPFactoryQos_idl
  OUTPUT_NAME DDS_DPFactoryQos_idl
  FOLDER tests/DCPS/DPFactoryQos
  DEFINE_SYMBOL DPFACTORYQOS_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_DPFactoryQos_idl
  DDS_IDL_FLAGS -Wb,export_macro=DPFactoryQos_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=DPFactoryQos_export.h
                -Wb,stub_export_macro=DPFactoryQos_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_DPFactoryQos_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/DPFactoryQos
  LINK_LIBRARIES DDS_DPFactoryQos_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_DPFactoryQos_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/DPFactoryQos
  LINK_LIBRARIES DDS_DPFactoryQos_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/DPFactoryQos/run_test.pl"
  COMMAND run_test.pl
)
