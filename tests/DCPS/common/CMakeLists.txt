

ace_add_lib(common
  OUTPUT_NAME common

  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(common
  SOURCE_FILES SampleInfo.cpp
               TestException.cpp
  HEADER_FILES SampleInfo.h
               TestException.h
)

