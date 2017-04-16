project(LivelinessKeepAliveTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(DDS_LivelinessKeepAliveTest_Idl
  OUTPUT_NAME DDS_LivelinessKeepAliveTest_Idl
  DEFINE_SYMBOL LIVELINESSKEEPALIVETEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_LivelinessKeepAliveTest_Idl
  DDS_IDL_FLAGS -Wb,export_macro=LivelinessKeepAliveTest_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=LivelinessKeepAliveTest_export.h
                -Wb,stub_export_macro=LivelinessKeepAliveTest_Export
                -SS
  IDL_FILES Satellite.idl
)


ace_add_exe(LivelinessKeepAliveTestPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_LivelinessKeepAliveTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(LivelinessKeepAliveTestPublisher
  SOURCE_FILES common.cpp
               publisher.cpp
  HEADER_FILES common.h
)


ace_add_exe(LivelinessKeepAliveTestSubscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_LivelinessKeepAliveTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(LivelinessKeepAliveTestSubscriber
  SOURCE_FILES AlertDataReaderListenerImpl.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES AlertDataReaderListenerImpl.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/LivelinessKeepAliveTest/run_test.pl"
  COMMAND run_test.pl
)
