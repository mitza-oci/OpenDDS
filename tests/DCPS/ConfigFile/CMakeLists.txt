project(ConfigFile CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(ConfigFile
  OUTPUT_NAME ConfigFile
  SOURCE_FILES ConfigFile.cpp
  FOLDER tests/DCPS/ConfigFile
  LINK_LIBRARIES OpenDDS_InfoRepoDiscovery
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 OpenDDS_Udp
                 OpenDDS_Rtps
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/ConfigFile/run_test.pl"
  COMMAND run_test.pl
)
