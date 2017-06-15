project(TransientLocalMultiInstanceTest CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_lib(DDS_TransientLocalMultiInstanceTest_Idl
  OUTPUT_NAME DDS_TransientLocalTest_Idl
  DEFINE_SYMBOL TRANSIENTLOCALMULTIINSTANCETEST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_TransientLocalMultiInstanceTest_Idl
  DDS_IDL_FLAGS -Wb,export_macro=TransientLocalMultiInstanceTest_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=TransientLocalMultiInstanceTest_export.h
                -Wb,stub_export_macro=TransientLocalMultiInstanceTest_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_TransientLocalMultiInstanceTest_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_TransientLocalMultiInstanceTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_TransientLocalTest_Publisher
  SOURCE_FILES publisher.cpp
)


ace_add_exe(DDS_TransientLocalMultiInstanceTest_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_TransientLocalMultiInstanceTest_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_TransientLocalMultiInstanceTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/TransientLocalMultiInstanceTest/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/TransientLocalMultiInstanceTest/run_test.pl rtps"
  COMMAND run_test.pl rtps
  REQUIRES BUILD_SHARED_LIBS
  LABELS RTPS
)

dds_add_test("tests/DCPS/TransientLocalMultiInstanceTest/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  REQUIRES BUILD_SHARED_LIBS
  LABELS RTPS
)
