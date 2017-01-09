project(error_handling CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(error_handling
  OUTPUT_NAME error_handling
  FOLDER tests/transport/error_handling
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
)
target_cxx_sources(error_handling
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/transport/error_handling/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS_TRANSPORT
)
