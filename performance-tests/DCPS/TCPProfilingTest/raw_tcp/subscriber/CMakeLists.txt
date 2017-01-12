
project(raw_tcp_subscriber CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT ACE_ROOT)
  find_package(ACE REQUIRED CONFIG)
endif()


add_ace_exe(DCPS_Perf_raw_tcp_subscriber
  OUTPUT_NAME raw_tcp_subscriber
  FOLDER performance-tests/DCPS/TCPProfilingTest/raw_tcp/subscriber
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../common
  LINK_LIBRARIES ACE
)
target_cxx_sources(DCPS_Perf_raw_tcp_subscriber
  SOURCE_FILES TcpSubscriber.cpp
               TestDriver.cpp
               main.cpp
  HEADER_FILES TcpSubscriber.h
               TestDriver.h
)

