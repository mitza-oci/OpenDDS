

ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(DCPS_Perf_UDPListener_Pub
  OUTPUT_NAME publisher
  FOLDER performance-tests/DCPS/UDPListenerTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DCPS_Perf_UDPListener_Pub
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
               common.h
)


ace_add_exe(DCPS_Perf_UDPListener_Sub
  OUTPUT_NAME subscriber
  FOLDER performance-tests/DCPS/UDPListenerTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DCPS_Perf_UDPListener_Sub
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               TestStats.h
               common.h
)

