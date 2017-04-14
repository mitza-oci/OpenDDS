

ace_add_lib(TestUtils
  OUTPUT_NAME TestUtils
  DEFINE_SYMBOL TESTUTILS_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(TestUtils
  SOURCE_FILES DDSApp.cpp
               Options.cpp
  HEADER_FILES DDSApp.h
               Options.h
)

