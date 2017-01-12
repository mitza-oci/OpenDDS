project(ConfigFile CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(ConfigFile
  OUTPUT_NAME ConfigFile
  FOLDER tests/DCPS/ConfigFile
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_InfoRepoDiscovery
                 OpenDDS_Multicast
                 OpenDDS_Tcp
                 OpenDDS_Udp
                 OpenDDS_Rtps
)
ace_target_cxx_sources(ConfigFile
  SOURCE_FILES ConfigFile.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ConfigFile/run_test.pl"
  COMMAND run_test.pl
)
