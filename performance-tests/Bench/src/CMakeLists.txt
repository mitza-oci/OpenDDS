
project(TestProcess CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(BenchProcess
  OUTPUT_NAME ../bin/testprocess
  LINK_LIBRARIES TAO_AnyTypeCode
                 TAO_Svc_Utils
                 OpenDDS_Default_Discovery
                 OpenDDS_Transports_For_Test
  UNITY_CXX_MINIMUM_PARTITIONS 2
)
ace_target_cxx_sources(BenchProcess
  SOURCE_FILES EntityProfiles.cpp
               Options.cpp
               Process.cpp
               StatisticalValue.cpp
               Subscription.cpp
               testprocess.cpp
               ###
               DataReaderListener.cpp
               Publication.cpp
  HEADER_FILES DataReaderListener.h
               EntityProfiles.h
               Options.h
               Process.h
               Publication.h
               Shutdown.h
               StatisticalValue.h
               Subscription.h
  INLINE_FILES Options.inl
)

dds_idl_sources(
  TARGETS BenchProcess
  TAO_IDL_FLAGS -Sa
                -St
                -I${TAO_INCLUDE_DIR}/orbsvcs
  IDL_FILES Test.idl
)

ace_add_exe(BenchUdpLatency
  OUTPUT_NAME ../bin/udp_latency
  LINK_LIBRARIES ACE
  COMPILE_DEFINITIONS NOMINMAX
)

ace_target_cxx_sources(BenchUdpLatency
  SOURCE_FILES udp_latency.cpp
)

ace_add_exe(BenchTcpLatency
  OUTPUT_NAME ../bin/tcp_latency
  LINK_LIBRARIES ACE
  COMPILE_DEFINITIONS NOMINMAX
)

ace_target_cxx_sources(BenchTcpLatency
  SOURCE_FILES tcp_latency.cpp
)