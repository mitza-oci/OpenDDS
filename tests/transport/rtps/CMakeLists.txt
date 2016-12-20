project(DDS_transport_rtps CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(DDS_transport_rtps_pub
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
  FOLDER tests/transport/rtps
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)

add_ace_exe(DDS_transport_rtps_sub
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
  FOLDER tests/transport/rtps
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/transport/rtps/run_test.pl"
  COMMAND run_test.pl
  LABELS RTPS
)
