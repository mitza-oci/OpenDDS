
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
                -I${TAO_INCLUDE_DIR}/orbsvcs
  IDL_FILES Test.idl
)
