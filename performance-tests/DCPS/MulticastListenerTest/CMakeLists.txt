
if (WIN32)
  string(LENGTH "${CMAKE_CURRENT_BINARY_DIR}" binary_dir_len)
  if (binary_dir_len GREATER 100)
    set(CURRENT_BINARY_DIR_TOO_LONG ON)
  endif()
endif(WIN32)

ace_requires("NOT OPENDDS_SAFETY_PROFILE" "NOT CURRENT_BINARY_DIR_TOO_LONG")

ace_add_exe(DCPS_Perf_MulticastListenerTest_Pub
  OUTPUT_NAME publisher

  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DCPS_Perf_MulticastListenerTest_Pub
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


ace_add_exe(DCPS_Perf_MulticastListenerTest_Sub
  OUTPUT_NAME subscriber

  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DCPS_Perf_MulticastListenerTest_Sub
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               TestStats.h
               common.h
)

