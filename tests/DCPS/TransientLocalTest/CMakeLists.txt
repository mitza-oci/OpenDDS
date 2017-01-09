project(TransientLocalTest CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE)

add_ace_lib(DDS_TransientLocalTest_Idl
  OUTPUT_NAME DDS_TransientLocalTest_Idl
  FOLDER tests/DCPS/TransientLocalTest
  DEFINE_SYMBOL TRANSIENTLOCALTEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_TransientLocalTest_Idl
  DDS_IDL_FLAGS -Wb,export_macro=TransientLocalTest_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=TransientLocalTest_export.h
                -Wb,stub_export_macro=TransientLocalTest_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_TransientLocalTest_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/TransientLocalTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
                 DDS_TransientLocalTest_Idl
)
target_cxx_sources(DDS_TransientLocalTest_Publisher
  SOURCE_FILES publisher.cpp
)


add_ace_exe(DDS_TransientLocalTest_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/TransientLocalTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
                 DDS_TransientLocalTest_Idl
)
target_cxx_sources(DDS_TransientLocalTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/TransientLocalTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/TransientLocalTest/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES BUILD_SHARED_LIBS
  LABELS RTPS
)
