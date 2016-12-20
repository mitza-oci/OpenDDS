
project(raw_tcp_latency_subscriber CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT ACE_ROOT)
  find_package(ACE REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DCPS_Perf_raw_tcp_latency_subscriber
  OUTPUT_NAME raw_tcp_subscriber
  SOURCE_FILES TestDriver.cpp
               main.cpp
  HEADER_FILES TestDriver.h
  FOLDER performance-tests/DCPS/SimpleLatency/raw_tcp/subscriber
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../common
)
