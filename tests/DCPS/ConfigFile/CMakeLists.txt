project(ConfigFile CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(ConfigFile
  OUTPUT_NAME ConfigFile
  FOLDER tests/DCPS/ConfigFile
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_InfoRepoDiscovery
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 OpenDDS_Udp
                 OpenDDS_Rtps
)
target_cxx_sources(ConfigFile
  SOURCE_FILES ConfigFile.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ConfigFile/run_test.pl"
  COMMAND run_test.pl
)
