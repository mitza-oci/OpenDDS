project(GroupPresentation CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OBJECT_MODEL_PROFILE)

add_ace_lib(DDS_GroupPresentation_Idl
  OUTPUT_NAME DDS_GroupPresentation_Idl
  FOLDER tests/DCPS/GroupPresentation
  DEFINE_SYMBOL GROUPPRESENTATION_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_GroupPresentation_Idl
  DDS_IDL_FLAGS -Wb,export_macro=GroupPresentation_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=GroupPresentation_export.h
                -Wb,stub_export_macro=GroupPresentation_Export
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_GroupPresentation_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/GroupPresentation
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_GroupPresentation_Idl
)
target_cxx_sources(DDS_GroupPresentation_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_GroupPresentation_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/GroupPresentation
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_GroupPresentation_Idl
)
target_cxx_sources(DDS_GroupPresentation_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               SubscriberListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               SubscriberListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/GroupPresentation/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/GroupPresentation/run_test.pl topic"
  COMMAND run_test.pl topic
)


add_dds_test("tests/DCPS/GroupPresentation/run_test.pl instance"
  COMMAND run_test.pl instance
)
