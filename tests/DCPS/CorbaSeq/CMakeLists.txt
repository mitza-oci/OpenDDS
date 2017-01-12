project(CorbaSeq CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(CorbaSeq_Idl
  OUTPUT_NAME CorbaSeq_Idl
  FOLDER tests/DCPS/CorbaSeq
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


add_ace_exe(CorbaSeq_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/CorbaSeq
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES CorbaSeq_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(CorbaSeq_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(CorbaSeq_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/CorbaSeq
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES CorbaSeq_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(CorbaSeq_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/CorbaSeq/run_test.pl"
  COMMAND run_test.pl
)
