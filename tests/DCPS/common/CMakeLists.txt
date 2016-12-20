

add_ace_lib(common
  OUTPUT_NAME common
  SOURCE_FILES SampleInfo.cpp
               TestException.cpp
  HEADER_FILES SampleInfo.h
               TestException.h
  FOLDER tests/DCPS/common
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
