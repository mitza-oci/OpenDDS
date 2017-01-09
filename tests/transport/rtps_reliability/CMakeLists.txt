project(DDS_transport_rtps_reliability CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(DDS_transport_rtps_reliability
  OUTPUT_NAME DDS_transport_rtps_reliability
  FOLDER tests/transport/rtps_reliability
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Rtps_Udp
)
target_cxx_sources(DDS_transport_rtps_reliability
  SOURCE_FILES rtps_reliability.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/transport/rtps_reliability/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
