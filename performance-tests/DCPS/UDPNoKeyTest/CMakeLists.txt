

requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DCPS_Perf_UDPNoKey_Pub
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES common.h
               TestException.h
               Writer.h
  FOLDER performance-tests/DCPS/UDPNoKeyTest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(DCPS_Perf_UDPNoKey_Sub
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               Reader.cpp
  HEADER_FILES common.h
               TestStats.h
               TestException.h
               Reader.h
  FOLDER performance-tests/DCPS/UDPNoKeyTest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
