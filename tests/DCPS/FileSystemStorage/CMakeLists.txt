project(FileSystemStorage CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_lib(FileSystemStorage
  OUTPUT_NAME FileSystemStorage
  FOLDER tests/DCPS/FileSystemStorage
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(FileSystemStorage
  SOURCE_FILES FileSystemStorageTest.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FileSystemStorage/run_test.pl"
  COMMAND run_test.pl
)
