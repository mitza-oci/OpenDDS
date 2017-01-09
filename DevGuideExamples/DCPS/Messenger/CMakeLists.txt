project(Messenger CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(Messenger_Publisher
  OUTPUT_NAME publisher
  FOLDER DevGuideExamples/DCPS/Messenger
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
)
target_cxx_sources(Messenger_Publisher
  SOURCE_FILES Publisher.cpp
)

dds_idl_sources(
  TARGETS Messenger_Publisher
  IDL_FILES Messenger.idl
)


add_ace_exe(Messenger_Subscriber
  OUTPUT_NAME subscriber
  FOLDER DevGuideExamples/DCPS/Messenger
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
)
target_cxx_sources(Messenger_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
)

dds_idl_sources(
  TARGETS Messenger_Subscriber
  IDL_FILES Messenger.idl
)


dds_idl_sources(
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("DevGuideExamples/DCPS/Messenger/run_test.pl"
  COMMAND run_test.pl
)
