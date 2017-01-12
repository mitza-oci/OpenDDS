
project(TestProcess CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(BenchProcess
  OUTPUT_NAME testprocess
  FOLDER performance-tests/Bench/src
  ASPECTS TAO
          DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES TAO_AnyTypeCode
                 TAO_Svc_Utils
                 OpenDDS_Dcps
)
ace_target_cxx_sources(BenchProcess
  SOURCE_FILES DataReaderListener.cpp
               EntityProfiles.cpp
               Options.cpp
               Process.cpp
               Publication.cpp
               StatisticalValue.cpp
               Subscription.cpp
               testprocess.cpp
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
                -I${TAO_ROOT}/orbsvcs
  IDL_FILES Test.idl
)
