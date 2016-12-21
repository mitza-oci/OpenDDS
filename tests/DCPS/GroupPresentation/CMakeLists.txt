project(GroupPresentation CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OBJECT_MODEL_PROFILE)

add_ace_lib(DDS_GroupPresentation_idl
  OUTPUT_NAME DDS_GroupPresentation_idl
  FOLDER tests/DCPS/GroupPresentation
  DEFINE_SYMBOL GROUPPRESENTATION_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_GroupPresentation_idl
  DDS_IDL_FLAGS -Wb,export_macro=GroupPresentation_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=GroupPresentation_export.h
                -Wb,stub_export_macro=GroupPresentation_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_GroupPresentation_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/GroupPresentation
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_GroupPresentation_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(DDS_GroupPresentation_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
               SubscriberListener.cpp
  HEADER_FILES DataReaderListener.h
               SubscriberListener.h
  FOLDER tests/DCPS/GroupPresentation
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_GroupPresentation_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
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
