
project(TestProcess CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
find_package(TAO_orbsvcs REQUIRED CONFIG)

requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(BenchProcess
  OUTPUT_NAME testprocess
  SOURCE_FILES StatisticalValue.cpp
               EntityProfiles.cpp
               Options.cpp
               Publication.cpp
               Subscription.cpp
               DataReaderListener.cpp
               Process.cpp
               testprocess.cpp
  HEADER_FILES Shutdown.h
               StatisticalValue.h
               EntityProfiles.h
               Options.h
               Publication.h
               Subscription.h
               DataReaderListener.h
               Process.h
  INLINE_FILES Options.inl
  FOLDER performance-tests/Bench/src
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 TAO_Svc_Utils
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_dds_idl_files(
  TARGETS BenchProcess
  IDL_FILES Test.idl
)
