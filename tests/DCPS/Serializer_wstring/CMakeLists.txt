project(Serializer_wstring CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(Serializer_wstring_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Serializer_wstring
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Serializer_wstring_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)

dds_idl_sources(
  TARGETS Serializer_wstring_Publisher
  IDL_FILES Messenger.idl
)


ace_add_exe(Serializer_wstring_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Serializer_wstring
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Serializer_wstring_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

dds_idl_sources(
  TARGETS Serializer_wstring_Subscriber
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Serializer_wstring/run_test.pl"
  COMMAND run_test.pl
)
