project(Rejects CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(DDS_Rejects_idl
  OUTPUT_NAME DDS_Rejects_idl
  FOLDER tests/DCPS/Rejects
  DEFINE_SYMBOL REJECTS_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Rejects_idl
  DDS_IDL_FLAGS -Wb,export_macro=Rejects_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Rejects_export.h
                -Wb,stub_export_macro=Rejects_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Rejects_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/Rejects
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Rejects_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_Rejects_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/Rejects
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Rejects_idl
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Rejects/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/Rejects/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
