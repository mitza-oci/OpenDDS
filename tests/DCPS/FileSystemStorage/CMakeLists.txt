project(FileSystemStorage CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(FileSystemStorage
  OUTPUT_NAME FileSystemStorageTest
  FOLDER tests/DCPS/FileSystemStorage
  LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(FileSystemStorage
  SOURCE_FILES FileSystemStorageTest.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FileSystemStorage/run_test.pl"
  COMMAND run_test.pl
)
