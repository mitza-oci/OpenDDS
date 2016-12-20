
project(MessengerMinimal CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(MessengerMinimal_publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
               Boilerplate.cpp
  HEADER_FILES Boilerplate.h
  FOLDER DevGuideExamples/DCPS/Messenger.minimal
  LINK_LIBRARIES OpenDDS_Model
                 OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(MessengerMinimal_subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               Subscriber.cpp
               Boilerplate.cpp
  HEADER_FILES DataReaderListenerImpl.h
               Boilerplate.h
  FOLDER DevGuideExamples/DCPS/Messenger.minimal
  LINK_LIBRARIES OpenDDS_Model
                 OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_dds_idl_files(
  TARGETS MessengerMinimal_publisher
          MessengerMinimal_subscriber
  IDL_FILES Messenger.idl
)
