project(ZeroCopyRead CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(ZeroCopyRead
  OUTPUT_NAME main
  FOLDER tests/DCPS/ZeroCopyRead
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(ZeroCopyRead
  SOURCE_FILES main.cpp
)

dds_idl_sources(
  TARGETS ZeroCopyRead
  TAO_IDL_FLAGS -SS
  IDL_FILES Simple.idl
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ZeroCopyRead/run_test.pl"
  COMMAND run_test.pl
)


add_dds_test("tests/DCPS/ZeroCopyRead/run_test.pl by_instance"
  COMMAND run_test.pl by_instance
)
