

add_ace_lib(common
  OUTPUT_NAME common
  FOLDER tests/DCPS/common
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(common
  SOURCE_FILES SampleInfo.cpp
               TestException.cpp
  HEADER_FILES SampleInfo.h
               TestException.h
)

