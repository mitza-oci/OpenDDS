project(FileSystemStorage CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(FileSystemStorage
  OUTPUT_NAME FileSystemStorage
  FOLDER tests/DCPS/FileSystemStorage
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(FileSystemStorage
  SOURCE_FILES FileSystemStorageTest.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/FileSystemStorage/run_test.pl"
  COMMAND run_test.pl
)
