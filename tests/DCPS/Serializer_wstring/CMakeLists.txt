project(Serializer_wstring CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(Serializer_wstring_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Serializer_wstring
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(Serializer_wstring_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)

dds_idl_sources(
  TARGETS Serializer_wstring_Publisher
  IDL_FILES Messenger.idl
)


add_ace_exe(Serializer_wstring_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Serializer_wstring
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(Serializer_wstring_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

dds_idl_sources(
  TARGETS Serializer_wstring_Subscriber
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Serializer_wstring/run_test.pl"
  COMMAND run_test.pl
)
