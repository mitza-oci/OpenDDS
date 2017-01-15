project(Lifespan CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OWNERSHIP_PROFILE)

ace_add_lib(DDS_Lifespan_Idl
  OUTPUT_NAME DDS_Lifespan_Idl
  FOLDER tests/DCPS/Lifespan
  DEFINE_SYMBOL LIFESPAN_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Lifespan_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Lifespan_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Lifespan_export.h
                -Wb,stub_export_macro=Lifespan_Export
                -SS
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Lifespan_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Lifespan
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Lifespan_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Lifespan_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
)


ace_add_exe(DDS_Lifespan_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Lifespan
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_Lifespan_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Lifespan_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Lifespan/run_test.pl"
  COMMAND run_test.pl
)
