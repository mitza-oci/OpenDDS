project(PersistentDurability CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(PERSISTENCE_PROFILE)

ace_add_lib(DDS_PersistentDurability_Idl
  OUTPUT_NAME DDS_PersistentDurability_Idl
  FOLDER tests/DCPS/PersistentDurability
  DEFINE_SYMBOL PERSISTENTDURABILITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_PersistentDurability_Idl
  DDS_IDL_FLAGS -Wb,export_macro=PersistentDurability_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=PersistentDurability_export.h
                -Wb,stub_export_macro=PersistentDurability_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_PersistentDurability_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/PersistentDurability
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_PersistentDurability_Idl
)
ace_target_cxx_sources(DDS_PersistentDurability_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


ace_add_exe(DDS_PersistentDurability_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/PersistentDurability
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_PersistentDurability_Idl
)
ace_target_cxx_sources(DDS_PersistentDurability_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/PersistentDurability/run_test.pl"
  COMMAND run_test.pl
)
