

ace_add_exe(DCPS_Perf_SimpleE2E_Pub
  OUTPUT_NAME publisher
  FOLDER performance-tests/DCPS/SimpleE2ETest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DCPS_Perf_SimpleE2E_Pub
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES TestException.h
               Writer.h
               common.h
)
ace_target_cxx_sources(DCPS_Perf_SimpleE2E_Pub
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES TestException.h
               Writer.h
               common.h
)



ace_add_exe(DCPS_Perf_SimpleE2E_Sub
  OUTPUT_NAME subscriber
  FOLDER performance-tests/DCPS/SimpleE2ETest
  LINK_LIBRARIES DCPS_Perf_TypeNoKeyBounded
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DCPS_Perf_SimpleE2E_Sub
  SOURCE_FILES Reader.cpp
               subscriber.cpp
  HEADER_FILES Reader.h
               TestException.h
               TestStats.h
               common.h
)

