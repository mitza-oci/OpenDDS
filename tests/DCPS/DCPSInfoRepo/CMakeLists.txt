project(dcpsinfo_test CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(dcpsinfo_test_Pubsub
  OUTPUT_NAME pubsub
  FOLDER tests/DCPS/DCPSInfoRepo
  LINK_LIBRARIES OpenDDS_Rtps_Udp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(dcpsinfo_test_Pubsub
  SOURCE_FILES DCPSDataReaderI.cpp
               DCPSDataWriterI.cpp
               DiscReceivedCalls.cpp
               pubsub.cpp
  HEADER_FILES DCPSDataReaderI.h
               DCPSDataWriterI.h
               DiscReceivedCalls.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/DCPSInfoRepo/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)


dds_add_test("tests/DCPS/DCPSInfoRepo/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
