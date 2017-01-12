
project(raw_tcp_latency_publisher CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT ACE_ROOT)
  find_package(ACE REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DCPS_Perf_raw_tcp_latency_publisher
  OUTPUT_NAME raw_tcp_publisher
  FOLDER performance-tests/DCPS/SimpleLatency/raw_tcp/publisher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../common
  LINK_LIBRARIES ACE
)
target_cxx_sources(DCPS_Perf_raw_tcp_latency_publisher
  SOURCE_FILES TcpPublisher.cpp
               TestDriver.cpp
               main.cpp
  HEADER_FILES TcpPublisher.h
               TestDriver.h
)

