project(dcpsinfo_test CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(dcpsinfo_test_pubsub
  OUTPUT_NAME pubsub
  SOURCE_FILES DCPSDataReaderI.cpp
               DCPSDataWriterI.cpp
               DiscReceivedCalls.cpp
               pubsub.cpp
  HEADER_FILES DCPSDataReaderI.h
               DCPSDataWriterI.h
               DiscReceivedCalls.h
  FOLDER tests/DCPS/DCPSInfoRepo
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/DCPSInfoRepo/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/DCPSInfoRepo/run_test.pl rtps_disc"
  COMMAND run_test.pl rtps_disc
  LABELS MCAST RTPS
)
