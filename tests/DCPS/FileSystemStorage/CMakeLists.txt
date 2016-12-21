project(FileSystemStorage CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(FileSystemStorage
  OUTPUT_NAME FileSystemStorage
  SOURCE_FILES FileSystemStorageTest.cpp
  FOLDER tests/DCPS/FileSystemStorage
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/FileSystemStorage/run_test.pl"
  COMMAND run_test.pl
)
