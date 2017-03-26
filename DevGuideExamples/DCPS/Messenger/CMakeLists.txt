project(Messenger CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(Messenger_Publisher
  OUTPUT_NAME publisher
  FOLDER DevGuideExamples/DCPS/Messenger
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Messenger_Publisher
  SOURCE_FILES Publisher.cpp
)

dds_idl_sources(
  TARGETS Messenger_Publisher
  IDL_FILES Messenger.idl
)


ace_add_exe(Messenger_Subscriber
  OUTPUT_NAME subscriber
  FOLDER DevGuideExamples/DCPS/Messenger
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Messenger_Subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
)

dds_idl_sources(
  TARGETS Messenger_Subscriber
  IDL_FILES Messenger.idl
)


include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("DevGuideExamples/DCPS/Messenger/run_test.pl"
  COMMAND run_test.pl
)
