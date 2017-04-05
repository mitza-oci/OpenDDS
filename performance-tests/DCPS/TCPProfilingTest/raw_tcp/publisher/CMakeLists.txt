
project(raw_tcp_publisher CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT TARGET ACE)
  find_package(ACE REQUIRED CONFIG)
endif()


ace_add_exe(DCPS_Perf_raw_tcp_publisher
  OUTPUT_NAME raw_tcp_publisher

  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../common
  LINK_LIBRARIES ACE
)
ace_target_cxx_sources(DCPS_Perf_raw_tcp_publisher
  SOURCE_FILES TcpPublisher.cpp
               TestDriver.cpp
               main.cpp
  HEADER_FILES TcpPublisher.h
               TestDriver.h
)

