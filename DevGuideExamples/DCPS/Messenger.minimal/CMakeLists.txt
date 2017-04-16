
project(MessengerMinimal CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(MessengerMinimal_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(MessengerMinimal_Publisher
  SOURCE_FILES Boilerplate.cpp
               Publisher.cpp
  HEADER_FILES Boilerplate.h
)

dds_idl_sources(
  TARGETS MessengerMinimal_Publisher
  IDL_FILES Messenger.idl
)


ace_add_exe(MessengerMinimal_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(MessengerMinimal_Subscriber
  SOURCE_FILES Boilerplate.cpp
               DataReaderListenerImpl.cpp
               Subscriber.cpp
  HEADER_FILES Boilerplate.h
               DataReaderListenerImpl.h
)

dds_idl_sources(
  TARGETS MessengerMinimal_Subscriber
  IDL_FILES Messenger.idl
)
