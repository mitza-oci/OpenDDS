project(StatusCondition CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(PERSISTENCE_PROFILE)

add_ace_exe(StatusCondition
  OUTPUT_NAME StatusConditionTest
  SOURCE_FILES StatusConditionTest.cpp
  FOLDER tests/DCPS/StatusCondition
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)
dds_idl_sources(
  TARGETS StatusCondition
  TAO_IDL_FLAGS -SS
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/StatusCondition/run_test.pl"
  COMMAND run_test.pl
)
