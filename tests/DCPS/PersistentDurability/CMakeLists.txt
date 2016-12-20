project(PersistentDurability CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(PERSISTENCE_PROFILE)

add_ace_lib(DDS_PersistentDurability_idl
  OUTPUT_NAME DDS_PersistentDurability_idl
  FOLDER tests/DCPS/PersistentDurability
  DEFINE_SYMBOL PERSISTENTDURABILITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_PersistentDurability_idl
  DDS_IDL_FLAGS -Wb,export_macro=PersistentDurability_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=PersistentDurability_export.h
                -Wb,stub_export_macro=PersistentDurability_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_PersistentDurability_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES Writer.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/PersistentDurability
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_PersistentDurability_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(DDS_PersistentDurability_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/PersistentDurability
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_PersistentDurability_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/PersistentDurability/run_test.pl"
  COMMAND run_test.pl
)
