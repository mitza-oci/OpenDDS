project(DDS_transport_rtps CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(DDS_transport_rtps_Pub
  OUTPUT_NAME publisher
  FOLDER tests/transport/rtps
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(DDS_transport_rtps_Pub
  SOURCE_FILES publisher.cpp
)


ace_add_exe(DDS_transport_rtps_Sub
  OUTPUT_NAME subscriber
  FOLDER tests/transport/rtps
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(DDS_transport_rtps_Sub
  SOURCE_FILES subscriber.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/transport/rtps/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
