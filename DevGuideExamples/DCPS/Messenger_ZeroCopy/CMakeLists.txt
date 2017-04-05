project(Messenger_ZeroCopy CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(Messenger_ZeroCopy_Idl
  OUTPUT_NAME Messenger_ZeroCopy_Idl

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


ace_add_exe(Messenger_ZeroCopy_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Tcp
                 Messenger_ZeroCopy_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Messenger_ZeroCopy_Publisher
  SOURCE_FILES Publisher.cpp
)


ace_add_exe(Messenger_ZeroCopy_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Tcp
                 Messenger_ZeroCopy_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Messenger_ZeroCopy_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("DevGuideExamples/DCPS/Messenger_ZeroCopy/run_test.pl"
  COMMAND run_test.pl
)
