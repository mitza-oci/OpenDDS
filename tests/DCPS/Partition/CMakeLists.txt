project(Partition CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DDS_Partition_Idl
  OUTPUT_NAME DDS_Partition_Idl
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


ace_add_exe(DDS_Partition_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Partition_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Partition_Publisher
  SOURCE_FILES DataWriterListener.cpp
               Publisher.cpp
  HEADER_FILES DataWriterListener.h
)


ace_add_exe(DDS_Partition_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Partition_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Partition_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Partition/run_test.pl"
  COMMAND run_test.pl
)
