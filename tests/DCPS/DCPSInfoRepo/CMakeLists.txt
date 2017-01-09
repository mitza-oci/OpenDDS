project(dcpsinfo_test CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(dcpsinfo_test_Pubsub
  OUTPUT_NAME pubsub
  FOLDER tests/DCPS/DCPSInfoRepo
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Rtps_Udp
)
target_cxx_sources(dcpsinfo_test_Pubsub
  SOURCE_FILES DCPSDataReaderI.cpp
               DCPSDataWriterI.cpp
               DiscReceivedCalls.cpp
               pubsub.cpp
  HEADER_FILES DCPSDataReaderI.h
               DCPSDataWriterI.h
               DiscReceivedCalls.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/DCPSInfoRepo/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/DCPSInfoRepo/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
