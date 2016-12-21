project(Lifespan CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE)

add_ace_lib(DDS_Lifespan_idl
  OUTPUT_NAME DDS_Lifespan_idl
  FOLDER tests/DCPS/Lifespan
  DEFINE_SYMBOL LIFESPAN_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Lifespan_idl
  DDS_IDL_FLAGS -Wb,export_macro=Lifespan_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Lifespan_export.h
                -Wb,stub_export_macro=Lifespan_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Lifespan_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
               DataWriterListenerImpl.cpp
  HEADER_FILES Writer.h
               DataWriterListenerImpl.h
  FOLDER tests/DCPS/Lifespan
  LINK_LIBRARIES DDS_Lifespan_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Lifespan_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Lifespan
  LINK_LIBRARIES DDS_Lifespan_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Lifespan/run_test.pl"
  COMMAND run_test.pl
)
