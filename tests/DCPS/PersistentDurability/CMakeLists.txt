project(PersistentDurability CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(PERSISTENCE_PROFILE)

add_ace_lib(DDS_PersistentDurability_Idl
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


add_ace_exe(DDS_PersistentDurability_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/PersistentDurability
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_PersistentDurability_Idl
)
target_cxx_sources(DDS_PersistentDurability_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


add_ace_exe(DDS_PersistentDurability_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/PersistentDurability
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_PersistentDurability_Idl
)
target_cxx_sources(DDS_PersistentDurability_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/PersistentDurability/run_test.pl"
  COMMAND run_test.pl
)
