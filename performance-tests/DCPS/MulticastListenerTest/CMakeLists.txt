

requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DCPS_Perf_MulticastListenerTest_Pub
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES common.h
               Writer.h
  FOLDER performance-tests/DCPS/MulticastListenerTest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(DCPS_Perf_MulticastListenerTest_Sub
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES common.h
               TestStats.h
               DataReaderListener.h
  FOLDER performance-tests/DCPS/MulticastListenerTest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
