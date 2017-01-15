project(DDS_transport_rtps_reliability CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(DDS_transport_rtps_reliability
  OUTPUT_NAME DDS_transport_rtps_reliability
  FOLDER tests/transport/rtps_reliability
  LINK_LIBRARIES OpenDDS_Rtps_Udp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_transport_rtps_reliability
  SOURCE_FILES rtps_reliability.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/transport/rtps_reliability/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
