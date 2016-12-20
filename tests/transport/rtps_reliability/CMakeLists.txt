project(DDS_transport_rtps_reliability CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(DDS_transport_rtps_reliability
  OUTPUT_NAME DDS_transport_rtps_reliability
  SOURCE_FILES rtps_reliability.cpp
  FOLDER tests/transport/rtps_reliability
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/transport/rtps_reliability/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
