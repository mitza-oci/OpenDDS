project(error_handling CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(error_handling
  OUTPUT_NAME error_handling
  FOLDER tests/transport/error_handling
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(error_handling
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/transport/error_handling/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS_TRANSPORT
)
