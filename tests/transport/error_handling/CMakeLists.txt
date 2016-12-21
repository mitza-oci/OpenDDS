project(error_handling CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(error_handling
  OUTPUT_NAME error_handling
  SOURCE_FILES main.cpp
  FOLDER tests/transport/error_handling
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/transport/error_handling/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS_TRANSPORT
)
