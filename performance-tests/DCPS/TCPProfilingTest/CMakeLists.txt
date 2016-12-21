
project(TCPProfiling CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DCPS_Perf_TCPProfiling_Pub
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES common.h
               Writer.h
  FOLDER performance-tests/DCPS/TCPProfilingTest
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DCPS_Perf_TCPProfiling_Pub
  IDL_FILES testMessage.idl
)

add_ace_exe(DCPS_Perf_TCPProfiling_Sub
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES common.h
               TestStats.h
               DataReaderListener.h
  FOLDER performance-tests/DCPS/TCPProfilingTest
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DCPS_Perf_TCPProfiling_Sub
  IDL_FILES testMessage.idl
)
add_subdirectory(raw_tcp)
