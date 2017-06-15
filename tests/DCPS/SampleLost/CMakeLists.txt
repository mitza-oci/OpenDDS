project(SampleLost CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_PERSISTENT_PROFILE)

ace_add_lib(DDS_SampleLost_Idl
  OUTPUT_NAME DDS_SampleLost_Idl
  DEFINE_SYMBOL SAMPLELOST_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_SampleLost_Idl
  DDS_IDL_FLAGS -Wb,export_macro=SampleLost_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=SampleLost_export.h
                -Wb,stub_export_macro=SampleLost_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_SampleLost_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_SampleLost_Idl
)
ace_target_cxx_sources(DDS_SampleLost_Publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
)


ace_add_exe(DDS_SampleLost_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_SampleLost_Idl
)
ace_target_cxx_sources(DDS_SampleLost_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/SampleLost/run_test.pl"
  COMMAND run_test.pl
)