
project(TCPProfiling CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
add_subdirectory(raw_tcp)


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DCPS_Perf_TCPProfiling_Pub
  OUTPUT_NAME publisher
  FOLDER performance-tests/DCPS/TCPProfilingTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(DCPS_Perf_TCPProfiling_Pub
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)

dds_idl_sources(
  TARGETS DCPS_Perf_TCPProfiling_Pub
  IDL_FILES testMessage.idl
)


add_ace_exe(DCPS_Perf_TCPProfiling_Sub
  OUTPUT_NAME subscriber
  FOLDER performance-tests/DCPS/TCPProfilingTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(DCPS_Perf_TCPProfiling_Sub
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               TestStats.h
               common.h
)

dds_idl_sources(
  TARGETS DCPS_Perf_TCPProfiling_Sub
  IDL_FILES testMessage.idl
)

