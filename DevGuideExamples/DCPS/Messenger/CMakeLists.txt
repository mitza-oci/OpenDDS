project(Messenger CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(Messenger_publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER DevGuideExamples/DCPS/Messenger
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(Messenger_subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES DataReaderListenerImpl.h
  FOLDER DevGuideExamples/DCPS/Messenger
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_dds_idl_files(
  TARGETS Messenger_publisher
          Messenger_subscriber
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("DevGuideExamples/DCPS/Messenger/run_test.pl"
  COMMAND run_test.pl
)
