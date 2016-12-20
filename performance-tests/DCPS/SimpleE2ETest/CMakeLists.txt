

add_ace_exe(DCPS_Perf_SimpleE2E_Pub
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES common.h
               TestException.h
               Writer.h
  FOLDER performance-tests/DCPS/SimpleE2ETest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(DCPS_Perf_SimpleE2E_Sub
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               Reader.cpp
  HEADER_FILES common.h
               TestStats.h
               TestException.h
               Reader.h
  FOLDER performance-tests/DCPS/SimpleE2ETest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)
