project(ReadCondition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(ReadCondition
  OUTPUT_NAME ReadConditionTest
  SOURCE_FILES ReadConditionTest.cpp
  FOLDER tests/DCPS/ReadCondition
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
dds_idl_sources(
  TARGETS ReadCondition
  TAO_IDL_FLAGS -SS
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ReadCondition/run_test.pl"
  COMMAND run_test.pl
)
