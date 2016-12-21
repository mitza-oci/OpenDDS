project(Partition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Partition_idl
  OUTPUT_NAME DDS_Partition_idl
  FOLDER tests/DCPS/Partition
  DEFINE_SYMBOL PARTITION_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Partition_idl
  DDS_IDL_FLAGS -Wb,export_macro=Partition_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Partition_export.h
                -Wb,stub_export_macro=Partition_Export
                -SS
  IDL_FILES Test.idl
)

add_ace_exe(DDS_Partition_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
               DataWriterListener.cpp
  HEADER_FILES DataWriterListener.h
  FOLDER tests/DCPS/Partition
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Partition_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Partition_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Partition
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Partition_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Partition/run_test.pl"
  COMMAND run_test.pl
)
