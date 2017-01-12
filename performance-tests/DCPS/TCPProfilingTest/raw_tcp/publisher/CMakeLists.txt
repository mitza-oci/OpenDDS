
project(raw_tcp_publisher CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT ACE_ROOT)
  find_package(ACE REQUIRED CONFIG)
endif()


add_ace_exe(DCPS_Perf_raw_tcp_publisher
  OUTPUT_NAME raw_tcp_publisher
  FOLDER performance-tests/DCPS/TCPProfilingTest/raw_tcp/publisher
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../common
  LINK_LIBRARIES ACE
)
target_cxx_sources(DCPS_Perf_raw_tcp_publisher
  SOURCE_FILES TcpPublisher.cpp
               TestDriver.cpp
               main.cpp
  HEADER_FILES TcpPublisher.h
               TestDriver.h
)

