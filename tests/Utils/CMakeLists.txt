

add_ace_lib(TestUtils
  OUTPUT_NAME TestUtils
  SOURCE_FILES DDSApp.cpp
               Options.cpp
  HEADER_FILES DDSApp.h
               Options.h
  FOLDER tests/Utils
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
