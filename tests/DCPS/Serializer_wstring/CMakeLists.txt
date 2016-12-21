project(Serializer_wstring CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(Serializer_wstring_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Serializer_wstring
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
dds_idl_sources(
  TARGETS Serializer_wstring_Publisher
  IDL_FILES Messenger.idl
)

add_ace_exe(Serializer_wstring_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Serializer_wstring
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
dds_idl_sources(
  TARGETS Serializer_wstring_Subscriber
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Serializer_wstring/run_test.pl"
  COMMAND run_test.pl
)
