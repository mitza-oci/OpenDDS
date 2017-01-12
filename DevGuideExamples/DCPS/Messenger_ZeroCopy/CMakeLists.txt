project(Messenger_ZeroCopy CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(Messenger_ZeroCopy_Idl
  OUTPUT_NAME Messenger_ZeroCopy_Idl
  FOLDER DevGuideExamples/DCPS/Messenger_ZeroCopy
  DEFINE_SYMBOL MESSENGER_ZEROCOPY_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS Messenger_ZeroCopy_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_ZeroCopy_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_ZeroCopy_export.h
                -Wb,stub_export_macro=Messenger_ZeroCopy_Export
  IDL_FILES Messenger.idl
)


add_ace_exe(Messenger_ZeroCopy_Publisher
  OUTPUT_NAME publisher
  FOLDER DevGuideExamples/DCPS/Messenger_ZeroCopy
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 Messenger_ZeroCopy_Idl
)
target_cxx_sources(Messenger_ZeroCopy_Publisher
  SOURCE_FILES Publisher.cpp
)


add_ace_exe(Messenger_ZeroCopy_Subscriber
  OUTPUT_NAME subscriber
  FOLDER DevGuideExamples/DCPS/Messenger_ZeroCopy
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 Messenger_ZeroCopy_Idl
)
target_cxx_sources(Messenger_ZeroCopy_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("DevGuideExamples/DCPS/Messenger_ZeroCopy/run_test.pl"
  COMMAND run_test.pl
)
