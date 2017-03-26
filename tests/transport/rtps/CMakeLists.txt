project(DDS_transport_rtps CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(DDS_transport_rtps_Pub
  OUTPUT_NAME publisher
  FOLDER tests/transport/rtps
  LINK_LIBRARIES OpenDDS_Rtps_Udp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_transport_rtps_Pub
  SOURCE_FILES publisher.cpp
)


ace_add_exe(DDS_transport_rtps_Sub
  OUTPUT_NAME subscriber
  FOLDER tests/transport/rtps
  LINK_LIBRARIES OpenDDS_Rtps_Udp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_transport_rtps_Sub
  SOURCE_FILES subscriber.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/transport/rtps/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
