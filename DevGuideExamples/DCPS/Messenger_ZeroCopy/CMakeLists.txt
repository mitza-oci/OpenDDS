project(Messenger_ZeroCopy CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(Messenger_ZeroCopy_idl
  OUTPUT_NAME Messenger_ZeroCopy_idl
  FOLDER DevGuideExamples/DCPS/Messenger_ZeroCopy
  DEFINE_SYMBOL MESSENGER_ZEROCOPY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS Messenger_ZeroCopy_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_ZeroCopy_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_ZeroCopy_export.h
                -Wb,stub_export_macro=Messenger_ZeroCopy_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(Messenger_ZeroCopy_publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER DevGuideExamples/DCPS/Messenger_ZeroCopy
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 Messenger_ZeroCopy_idl
)

add_ace_exe(Messenger_ZeroCopy_subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
  FOLDER DevGuideExamples/DCPS/Messenger_ZeroCopy
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 Messenger_ZeroCopy_idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("DevGuideExamples/DCPS/Messenger_ZeroCopy/run_test.pl"
  COMMAND run_test.pl
)
