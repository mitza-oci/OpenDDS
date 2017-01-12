project(Partition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Partition_Idl
  OUTPUT_NAME DDS_Partition_Idl
  FOLDER tests/DCPS/Partition
  DEFINE_SYMBOL PARTITION_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Partition_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Partition_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Partition_export.h
                -Wb,stub_export_macro=Partition_Export
                -SS
  IDL_FILES Test.idl
)


add_ace_exe(DDS_Partition_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Partition
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Partition_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Partition_Publisher
  SOURCE_FILES DataWriterListener.cpp
               Publisher.cpp
  HEADER_FILES DataWriterListener.h
)


add_ace_exe(DDS_Partition_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Partition
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_Partition_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_Partition_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Partition/run_test.pl"
  COMMAND run_test.pl
)
