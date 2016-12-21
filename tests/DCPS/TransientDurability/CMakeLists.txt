project(TransientDurability CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(PERSISTENCE_PROFILE)

add_ace_lib(DDS_TransientDurability_idl
  OUTPUT_NAME DDS_TransientDurability_idl
  FOLDER tests/DCPS/TransientDurability
  DEFINE_SYMBOL TRANSIENTDURABILITY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_TransientDurability_idl
  DDS_IDL_FLAGS -Wb,export_macro=TransientDurability_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=TransientDurability_export.h
                -Wb,stub_export_macro=TransientDurability_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_TransientDurability_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES Writer.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/TransientDurability
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_TransientDurability_idl
)

add_ace_exe(DDS_TransientDurability_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/TransientDurability
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_TransientDurability_idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/TransientDurability/run_test.pl"
  COMMAND run_test.pl
)
