

add_ace_lib(TestFramework
  OUTPUT_NAME TestFramework
  SOURCE_FILES TestFramework.cpp
  HEADER_FILES TestFramework.h
               TestFramework_T.h
  TEMPLATE_FILES TestFramework_T.cpp
  FOLDER tests/DCPS/TestFramework
  DEFINE_SYMBOL TESTFRAMEWORK_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS TestFramework
  DDS_IDL_FLAGS -Wb,export_macro=TestFramework_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=TestFramework_Export.h
                -Wb,stub_export_macro=TestFramework_Export
                -SS
  IDL_FILES TestFramework.idl
)
