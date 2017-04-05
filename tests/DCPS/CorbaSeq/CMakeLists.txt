project(CorbaSeq CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(CorbaSeq_Idl
  OUTPUT_NAME CorbaSeq_Idl

  DEFINE_SYMBOL CORBASEQ_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS CorbaSeq_Idl
  DDS_IDL_FLAGS -Wb,export_macro=CorbaSeq_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=CorbaSeq_export.h
                -Wb,stub_export_macro=CorbaSeq_Export
  IDL_FILES Messenger.idl
            Messenger2.idl
)


ace_add_exe(CorbaSeq_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 CorbaSeq_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(CorbaSeq_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(CorbaSeq_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 CorbaSeq_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(CorbaSeq_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/CorbaSeq/run_test.pl"
  COMMAND run_test.pl
)
