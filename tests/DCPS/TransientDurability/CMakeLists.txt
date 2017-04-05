project(TransientDurability CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_PERSISTENCE_PROFILE)

ace_add_lib(DDS_TransientDurability_Idl
  OUTPUT_NAME DDS_TransientDurability_Idl

  DEFINE_SYMBOL TRANSIENTDURABILITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_TransientDurability_Idl
  DDS_IDL_FLAGS -Wb,export_macro=TransientDurability_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=TransientDurability_export.h
                -Wb,stub_export_macro=TransientDurability_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_TransientDurability_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_TransientDurability_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_TransientDurability_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


ace_add_exe(DDS_TransientDurability_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_TransientDurability_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_TransientDurability_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/TransientDurability/run_test.pl"
  COMMAND run_test.pl
)
