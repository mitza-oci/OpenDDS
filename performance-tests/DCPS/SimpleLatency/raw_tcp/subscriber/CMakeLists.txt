
project(raw_tcp_latency_subscriber CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT TARGET ACE)
  find_package(ACE REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(DCPS_Perf_raw_tcp_latency_subscriber
  OUTPUT_NAME raw_tcp_subscriber
  FOLDER performance-tests/DCPS/SimpleLatency/raw_tcp/subscriber
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../common
  LINK_LIBRARIES ACE
)
ace_target_cxx_sources(DCPS_Perf_raw_tcp_latency_subscriber
  SOURCE_FILES TestDriver.cpp
               main.cpp
  HEADER_FILES TestDriver.h
)

